<?php

//fetch.php

$api_url = "http://localhost/cafeteria_colab/api/test_api.php?action=fetch_cliente";
$client = curl_init($api_url);

curl_setopt($client, CURLOPT_RETURNTRANSFER, true);

$response = curl_exec($client);

$result = json_decode($response);

$output = '';

if(count($result) > 0)
{
	foreach($result as $row)
	{
		$output .= '
		<tr>
			<td>'.$row->id_cliente.'</td>
			<td>'.$row->nombres.'</td>
			<td>'.$row->apellidos.'</td>
			<td>'.$row->celular.'</td>
			<td>'.$row->nit.'</td>
			<td>'.$row->fecha_creacion.'</td>
			<td><button type="button" name="edit_cliente" class="btn btn-warning btn-xs edit" id="'.$row->id_cliente.'">Edit</button></td>
			<td><button type="button" name="delete_cliente"  class="btn btn-danger btn-xs delete" id="'.$row->id_cliente.'">Delete</button></td>
		</tr>
		';
	}
}
else
{
	$output .= '
	<tr>
		<td colspan="4" align="center">No Data Found</td>
	</tr>
	';
}

echo $output;

?>