<?php

//test_api.php

include('Api.php');

$api_object = new API();

if($_GET["action"] == 'fetch_cliente')
{
	$data = $api_object->fetch_cliente();
}

if($_GET["action"] == 'insert_cliente')
{
	$data = $api_object->insert_cliente();
}

if($_GET["action"] == 'fetch_single_cliente')
{
	$data = $api_object->fetch_single_cliente($_GET["id"]);
}

if($_GET["action"] == 'update_cliente')
{
	$data = $api_object->update_cliente();
}

if($_GET["action"] == 'delete_cliente')
{
	$data = $api_object->delete_cliente($_GET["id"]);
}

echo json_encode($data);

?>