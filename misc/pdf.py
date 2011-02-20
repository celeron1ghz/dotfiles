# -*- coding: utf8 -*-
from reportlab.pdfbase import pdfmetrics
from reportlab.platypus import SimpleDocTemplate, Paragraph, Frame, PageTemplate, NextPageTemplate
from reportlab.platypus.flowables import HRFlowable
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.pdfbase.ttfonts import TTFont
import sys
#from reportlab.pdfbase.cidfonts import UnicodeCIDFont

import os
import yaml

class MySimpleDocTemplate(SimpleDocTemplate):
    #pdfmetrics.registerFont(UnicodeCIDFont("HeiseiKakuGo-W5"))
    pdfmetrics.registerFont(TTFont('IPA', os.environ['HOME'] + '/share/misc/ipag-mona.ttf'))
    PStyle = ParagraphStyle(name='Normal', fontName="IPA", fontSize=6, leading=7, borderWidth=1, wordWrap='CJK')
    #PStyle = ParagraphStyle(name='Normal', fontName="HeiseiKakuGo-W5", fontSize=6, leading=7, borderWidth=1, wordWrap='CJK')
    pageCount = 1

    def __init__(self,filename):
        self.leftMargin = 10
        self.rightMargin = 10
        self.topMargin = 10
        self.bottomMargin = 10
        SimpleDocTemplate.__init__(self,filename)

        self.addPageTemplates([
            PageTemplate(id="p1", frames=[
                 Frame(x1=10,  y1=415, width=255, height=405, showBoundary=1, topPadding=15)
                ,Frame(x1=265, y1=415, width=255, height=405, showBoundary=1, topPadding=15)
                ,Frame(x1=10,  y1=10,  width=255, height=405, showBoundary=1, topPadding=15)
                ,Frame(x1=265, y1=10,  width=255, height=405, showBoundary=1, topPadding=15)
            ])
        ])

    def handle_frameBegin(self):
        x = self.frame.x1 + self.frame.width - 15
        y = self.frame.y1 + self.frame.height - self.PStyle.leading

        self.canv.saveState()
        self.canv.setFont(self.PStyle.fontName, self.PStyle.fontSize)
        self.canv.drawRightString(x, y, "Page:%s" % (self.pageCount) )
        self.canv.restoreState()
        self.pageCount += 1
        SimpleDocTemplate.handle_frameBegin(self)

def go():
    args = sys.argv

    if ( len(args) != 3 ):
        raise Exception("invalid args")

    input = args[1]
    output = args[2]

    doc = MySimpleDocTemplate(output);
    Story = []

    data = yaml.load(open(input).read().decode('utf8'))

    for d in reversed(data):
        tweet = d['text'] + "<br />" + d['created_at'] + " " + str(d['id'])
        Story.append(Paragraph(tweet, doc.PStyle))
        Story.append(HRFlowable(width='110%'))
        Story.append(NextPageTemplate('p1'))

    doc.build(Story)

go()
