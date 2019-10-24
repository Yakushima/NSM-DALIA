from bs4 import BeautifulSoup;
import requests
import sys

url = "http://www.signbank.org/signpuddle2.0/translate.php"

for words in sys.argv[1:]:
    r = requests.post(url+"?ui=1&sgn=4&build="+words+"&action=translate")

    xmltext = r.text
    xml = xmltext.encode('utf-8')

    soup = BeautifulSoup(xml, "lxml")
    imgs = soup.find_all("img")

    try:
        file = open("html_nsm/"+words+".html", "w")
        for img in imgs:
            src = img["src"]
            if src.startswith("glyphogram.php"):
                src = 'http://www.signbank.org/signpuddle2.0/'+src
                img['src'] = src
                file.write(str(img))
        file.close()
    except:
            pass
