from bs4 import BeautifulSoup;
import requests

url = "http://www.signbank.org/signpuddle2.0/translate.php";

r = requests.post(url+"?ui=1&sgn=4&build=building&action=translate")

xmltext = r.text
xml = xmltext.encode('utf-8')

soup = BeautifulSoup(xml, "lxml")
imgs = soup.find_all("img")

print ("<html><body>");
for img in imgs:
    src = img["src"]
    if src.startswith("glyphogram.php"):
        src = 'http://www.signbank.org/signpuddle2.0/'+src
        img['src'] = src
        print(img)
print ("</body></html>");
