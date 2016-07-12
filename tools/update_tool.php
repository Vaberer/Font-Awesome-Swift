<?php
	// WHY THE HELL IS THIS IN PHP???
	// Firstly; I apologise for the PHP. It was a small tool hastily written when it ticked all the boxes, I caved.
	//	- It was quick to create
	//	- Has all the neccessary tools right there ready to implement
	//	- Web server was already in front of me, honest!
	//	- Why am I trying to jusify this again?
	
	// Also, by all means, this is very crude and not meant/designed/created/anything-to-that-nature for any sort of production use
	// But as a quick tool to grab the information to update; "it does the job" - PHP, - Michael Scott
	
	$yaml = yaml_parse_url('https://raw.githubusercontent.com/FortAwesome/Font-Awesome/master/src/icons.yml');
	
	foreach ($yaml['icons'] as $key => $icon) {
		
		$iconClass = str_replace(' ', '', ucwords(str_replace('-', ' ', $icon['id'])));
		
		$classes[] = "FA$iconClass";
		$codes[] = '"\u{'.$icon['unicode'].'}"';
		
		if (isset($icon['aliases'])) {
			
			foreach ($icon['aliases'] as $key => $class) {
				$aliasClass = str_replace(' ', '', ucwords(str_replace('-', ' ', $class)));
				$classes[] = "FA$aliasClass";
			}
			
			for ($c = count($icon['aliases']); $c > 0; --$c)
				$codes[] = '"\u{'.$icon['unicode'].'}"';
		}
	}
	
	$classStrings = implode('", "', $classes);
	$classes = implode(', ', $classes);
	$codes = implode(', ', $codes);
	
	echo "Classes:<br>case $classes<br><br>Unicode:<br>private let FAIcons = [$codes]<br><br>Helper:<br>let helper = [\"$classStrings\"]";
?>