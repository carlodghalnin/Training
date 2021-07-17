class analysedText(object):
    
    def __init__ (self, text):
        self.text = text
        formatted_text = text.lower().replace('.','').replace('!','').replace(',','').replace('?','')
        self.fmtText = formatted_text
        
    def freqAll(self):        
        words = self.fmtText.split(' ')
        freq_all = {}
        for word in words:
            if word not in freq_all:
                freq_all[word] = words.count(word)
            else:
                pass
        return(freq_all)
    
    def freqOf(self,word):
        words = self.fmtText.split(' ')
        freq_of = words.count(word)
        return(freq_of)

##a = analysedText("Lorem ipsum dolor! diam amet, consetetur Lorem magna."
##                 "sed diam nonumy eirmod tempor. diam et labore? et diam magna."
##                 "et diam amet.")
##print(a.fmtText)
##print(a.freqAll())
##print(a.freqOf('diam'))

samplePassage = analysedText("Lorem ipsum dolor! diam amet, "
                             "consetetur Lorem magna. sed diam nonumy eirmod "
                             "tempor. diam et labore? et diam magna. et diam "
                             "amet.")
samplePassage.fmtText == "lorem ipsum dolor diam amet consetetur lorem magna sed diam nonumy eirmod tempor diam et labore et diam magna et diam amet"
