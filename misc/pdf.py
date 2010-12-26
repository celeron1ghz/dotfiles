# -*- coding: utf8 -*-
from reportlab.pdfbase.cidfonts import UnicodeCIDFont
from reportlab.pdfbase import pdfmetrics
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Frame, PageTemplate, NextPageTemplate
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle

class MySimpleDocTemplate(SimpleDocTemplate):
    pdfmetrics.registerFont(UnicodeCIDFont("HeiseiKakuGo-W5"))
    PStyle = ParagraphStyle(name='Normal', fontName="HeiseiKakuGo-W5", fontSize=8, leading=10, borderWidth=1)
    pageCount = 1

    def __init__(self,filename):
        self.leftMargin = 10
        self.rightMargin = 10
        self.topMargin = 10
        self.bottomMargin = 10
        SimpleDocTemplate.__init__(self,filename)

        self.addPageTemplates([
            PageTemplate(id="p1", frames=[
                Frame(x1=10, y1=10, width=247,  height=390, showBoundary=1, topPadding=15)
                ,Frame(x1=10, y1=430, width=247, height=390, showBoundary=1, topPadding=15)
                ,Frame(x1=270, y1=10, width=247, height=390, showBoundary=1, topPadding=15)
                ,Frame(x1=270, y1=430, width=247, height=390, showBoundary=1, topPadding=15)
            ])
        ])

    def handle_frameBegin(self):
        x = self.frame.x1 + self.frame.width - self.PStyle.fontSize
        y = self.frame.y1 + self.frame.height - self.PStyle.leading

        self.canv.saveState()
        self.canv.setFont(self.PStyle.fontName, self.PStyle.fontSize)
        self.canv.drawRightString(x, y, "Page:%s" % (self.pageCount) )
        self.canv.restoreState()
        self.pageCount += 1
        SimpleDocTemplate.handle_frameBegin(self)

def go():
    doc = MySimpleDocTemplate("reportlab_japanese.pdf")
    Story = []
    Story.append(NextPageTemplate('p1'))

    for i in range(5):
        bogustext = (u"\rこんにちわこんにちわ！！") * 100
        Story.append(Paragraph(bogustext, doc.PStyle))
        Story.append(Spacer(0, 10))

    doc.build(Story)

go()
