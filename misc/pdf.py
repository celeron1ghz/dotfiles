# -*- coding: utf8 -*-
from reportlab.pdfbase.cidfonts import UnicodeCIDFont
from reportlab.pdfbase import pdfmetrics
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Frame, PageTemplate, NextPageTemplate
from reportlab.rl_config import defaultPageSize
from reportlab.lib.units import inch, cm
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle

pdfmetrics.registerFont(UnicodeCIDFont("HeiseiKakuGo-W5"))

PAGE_HEIGHT=defaultPageSize[1]
PAGE_WIDTH=defaultPageSize[0]

styles = getSampleStyleSheet()
my_style = styles["Normal"]
my_style.fontName = "HeiseiKakuGo-W5"

class MySimpleDocTemplate(SimpleDocTemplate):
    def handle_frameBegin(self):
        x = self.frame.x1 + self.frame.width - 5
        y = self.frame.y1 + self.frame.height - 12

        self.canv.saveState()
        self.canv.setFont("HeiseiKakuGo-W5", 9)
        self.canv.drawRightString(x, y, "Page:1")
        self.canv.restoreState()
        SimpleDocTemplate.handle_frameBegin(self)

def go():
    doc = MySimpleDocTemplate("reportlab_japanese.pdf")
    doc.leftMargin = 10
    doc.rightMargin = 10
    doc.topMargin = 10
    doc.bottomMargin = 10
    Story = []
    style = my_style

    for i in range(5):
        bogustext = (u"\rこんにちわこんにちわ！！") * 50
        #style.wordWrap = 'CJK'
        PStyle = ParagraphStyle(name='Normal', fontName="HeiseiKakuGo-W5", fontSize=8, leading=10, borderWidth=1)
        p = Paragraph(bogustext, PStyle)
        Story.append(NextPageTemplate('p1'))
        Story.append(p)
        Story.append(Spacer(0, 0 * inch))

    frame1 = Frame(x1=10, y1=10, width=247,  height=390, showBoundary=1, topPadding=15)
    frame2 = Frame(x1=10, y1=430, width=247, height=390, showBoundary=1, topPadding=15)
    frame3 = Frame(x1=270, y1=10, width=247, height=390, showBoundary=1, topPadding=15)
    frame4 = Frame(x1=270, y1=430, width=247, height=390, showBoundary=1, topPadding=15)
    page = PageTemplate(id="p1", frames=[frame1, frame2, frame3, frame4])
    doc.addPageTemplates([page])
    doc.build(Story)

go()
