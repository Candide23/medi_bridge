module TranslateServices
# NOTE: You did a great job handling different file types and extracting value! Nice work Candide!
  class TextExtractor
    include ActiveModel::Model
    attr_accessor :health_record

    def call
      return "" unless health_record&.document&.attached?

      # Use cached text if available
      return health_record.text_cache.to_s if health_record.text_cache.present?

      text = extract!
      text = text.to_s.strip

      # Cache it for faster subsequent translations
      if text.present?
        health_record.update_column(:text_cache, text) # skip validations/callbacks
      end

      text
    end

    private

    def extract!
      health_record.document.open(tmpdir: Dir.mktmpdir) do |file|
        ct = health_record.document.content_type.to_s

        if ct.start_with?('text/')
          return File.read(file.path)

        elsif image?(ct)
          return ocr_image(file.path, ocr_lang_for(health_record.language))

        elsif ct == 'application/pdf'
          text = extract_pdf_text(file.path)
          return text if text.present?
          return ocr_pdf(file.path, ocr_lang_for(health_record.language))
        else
          # unknown type — try OCR as last resort
          return ocr_image(file.path, ocr_lang_for(health_record.language))
        end
      end
    end

    def image?(content_type)
      content_type.start_with?('image/')
    end

    # ---- PDF: native text ----
    def extract_pdf_text(path)
      require 'pdf/reader'
      text = +""
      PDF::Reader.open(path) do |reader|
        reader.pages.each { |p| text << p.text.to_s << "\n" }
      end
      text.strip
    rescue => _
      ""
    end

    # ---- PDF: OCR each page ----
    def ocr_pdf(path, lang)
      require 'mini_magick'
      dir = Dir.mktmpdir
      # Convert PDF pages to PNGs (ImageMagick handles multi-page PDFs)
      MiniMagick::Tool::Convert.new do |convert|
        convert.density(300)
        convert.quality(90)
        convert << path
        convert << File.join(dir, "page-%02d.png")
      end
      images = Dir[File.join(dir, "page-*.png")].sort
      return "" if images.empty?

      images.map { |img| ocr_image(img, lang) }.join("\n\n").strip
    rescue => _
      ""
    ensure
      FileUtils.remove_entry(dir) if dir && Dir.exist?(dir)
    end

    # ---- Image OCR ----
    def ocr_image(path, lang)
      require 'rtesseract'
      RTesseract.new(path, lang: lang).to_s
    rescue => _
      ""
    end

    # Tesseract language codes
    # (install packs accordingly: eng, fra, spa, por, chi_sim, chi_tra, etc.)
    def ocr_lang_for(locale)
      case locale.to_s.downcase
      when 'en' then 'eng'
      when 'fr' then 'fra'
      when 'es' then 'spa'
      when 'pt', 'pt-br', 'pt-pt' then 'por'
      when 'zh', 'zh-cn' then 'chi_sim'
      when 'zh-tw' then 'chi_tra'
      else 'eng'
      end
    end
  end
end
