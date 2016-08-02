<?php
header('Content-Type: application/json');

$baseUrl = 'https://themachine.jeremystucki.com/api/v1/coop/menus';

$midnight = new DateTime;
$midnight->setTime(0, 0);

$timestamp = $midnight->getTimestamp();
$location = $_POST['text'];

$handle = curl_init();

curl_setopt($handle, CURLOPT_URL, $baseUrl . '/' . urlencode($location) . '/' . $timestamp);
curl_setopt($handle, CURLOPT_RETURNTRANSFER, true);

$body = curl_exec($handle);
curl_close($handle);

$data = json_decode($body, true);
$menus = [];

foreach($data['results'] as $menu) {
    $text = '*' . $menu['title'] . '* - ' . $menu['price'];
    
    foreach($menu['menu'] as $dish) {
        $text .= PHP_EOL . '-' . $dish;
    }

    $text .= PHP_EOL;

    $menus[] = $text;
}

$attachments = [];

if (!isset($data['results'][0])) {
    $attachments[] = [
	    'color' => 'warning',
    	'text' => 'We couldn\'t find any menus for \'' . $location . '\''
    ];
}

echo json_encode([
    'text' => implode(PHP_EOL, $menus),
    'parse' => 'full',
    'attachments' => $attachments
]);
