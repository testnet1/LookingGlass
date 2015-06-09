module ENAnalyzer
  extend IndexMethods
  
  def self.analyzerSettings
    loadDataspec
    return {
      index: {
        analysis: {
          filter: {
            english_stop: {
              type: 'stop',
              stopwords: '_english_'
            },
            english_stemmer: {
              type: 'stemmer',
              language: 'english'
            },
            english_possessive_stemmer: {
              type: 'stemmer',
              language: 'possessive_english'
            },
            synonyms: {
              type: 'synonym',
              synonyms: File.read(@synonym_list).split("\n")
            }
          },       
          analyzer: {
            custom_en_analyzer: {
            type: 'custom',
            tokenizer: 'standard',
            filter: [
                     "english_possessive_stemmer",
                     "lowercase",
                     "synonyms",
                     "english_stop",
                     "english_stemmer",
                     "asciifolding"
                    ]
            },
          },
        },
      },
    }.freeze
  end
end
