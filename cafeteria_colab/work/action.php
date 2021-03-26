<?php

//action.php
$url="http://localhost/cafeteria_colab/api/test_api.php";
if(isset($_POST["action"]))
{
	if($_POST["action"] == 'insert_cliente')
	{
		$form_data = array(
			'id_cliente'	=>	$_POST['id_cliente'],
			'nombres'	=>	$_POST['nombres'],
			'apellidos'		=>	$_POST['apellidos'],
			'celular'		=>	$_POST['celular'],
			'nit'		=>	$_POST['nit'],
			'fecha_creacion'		=>	$_POST['fecha_creacion']
		);
		$api_url = $url."?action=insert_cliente";  
		$client = curl_init($api_url);
		curl_setopt($client, CURLOPT_POST, true);
		curl_setopt($client, CURLOPT_POSTFIELDS, $form_data);
		curl_setopt($client, CURLOPT_RETURNTRANSFER, true);
		$response = curl_exec($client);
		curl_close($client);
		$result = json_decode($response, true);
		foreach($result as $keys => $values)
		{
			if($result[$keys]['success'] == '1')
			{
				echo 'insert';
			}
			else
			{
				echo 'error';
			}
		}
	}

	if($_POST["action"] == 'fetch_single_cliente')
	{
		$id = $_POST["id"];
		$api_url = $url."?action=fetch_single_cliente&id=$id";  
		$client = curl_init($api_url);
		curl_setopt($client, CURLOPT_RETURNTRANSFER, true);
		$response = curl_exec($client);
		echo $response;
	}
	if($_POST["action"] == 'update_cliente')
	{
		$form_data = array(
			'nombres'		=>	$_POST['nombres'],
			'apellidos'		=>	$_POST['apellidos'],
			'celular'			=>	$_POST['celular'],
			'nit'			=>	$_POST['nit'],
			'id_cliente'			=>	$_POST['hidden_id']
		);
		$api_url = $url."?action=update_cliente";  
		$client = curl_init($api_url);
		curl_setopt($client, CURLOPT_POST, true);
		curl_setopt($client, CURLOPT_POSTFIELDS, $form_data);
		curl_setopt($client, CURLOPT_RETURNTRANSFER, true);
		$response = curl_exec($client);
		curl_close($client);
		$result = json_decode($response, true);
		foreach($result as $keys => $values)
		{
			if($result[$keys]['success'] == '1')
			{
				echo 'update';
			}
			else
			{
				echo 'error';
			}
		}
	}
	if($_POST["action"] == 'delete_cliente')
	{
		$id = $_POST['id'];
		$api_url = $url."?action=delete_cliente&id=$id"; 
		$client = curl_init($api_url);
		curl_setopt($client, CURLOPT_RETURNTRANSFER, true);
		$response = curl_exec($client);
		echo $response;
	}
}


?>