// nodejs
var JSSoup = require('jssoup').default;

var url = "http://www.signbank.org/signpuddle2.0/translate.php";

// i don;t have a bot
var data;
function querySW() {
$.post(url+"?ui=1&sgn=4&build=building&action=translate", null, function(data, status, xhr) {
	console.log ("<html><body>");
	console.log(data);
	var xmltext = r.text
	var xml = xmltext.encode('utf-8')

	var soup = new JSSoup(xml)
	var imgs = soup.findAll("img")

	for (img in imgs) {
	    var src = imgs[img]["src"];
	    if (src.indexOf("glyphogram.php") > 1) {
		src = 'http://www.signbank.org/signpuddle2.0/'+src;
		imgs[img]['src'] = src;
		console.log(imgs[img]);
	     }
	}
	console.log ("</body></html>");
 });
};
