<?php

$response = json_decode(file_get_contents("php://stdin"), true);
$products = $response['_embedded']['items'];

$productsApiFormatPatch = '';
foreach ($products as $product) {
    unset($product['_links']);
    $productsApiFormatPatch .= json_encode($products) . PHP_EOL;
}
