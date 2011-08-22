module("setup", {
	setup: function() {
		parser = new SiteParser();
	}
});

test("unsupported url", function() {
	result = parser.parse("foobar.com");
	ok(!result);
});


test("github with username", function() {
	result = parser.parse("github.com/chrislloyd");
	ok(result);
	ok(result[0] == "github");
	ok(result[1].username == "chrislloyd");
});

test("dribbble with username", function() {
	result = parser.parse("dribbble.com/chrislloyd");
	ok(result);
	ok(result[0] == "dribbble");
	ok(result[1].username == "chrislloyd");
});

test("bitbucket with username", function() {
	result = parser.parse("bitbucket.com/chrislloyd");
	ok(result);
	ok(result[0] == "bitbucket");
	ok(result[1].username == "chrislloyd");
});