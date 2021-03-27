<?php

//Api.php
class Api
{
	private $connect = '';

	function __construct()
	{
		$this->database_connection();
	}

	function database_connection()
	{
		$this->connect = new PDO("mysql:host=localhost;dbname=cola_cafeteria","root","");
	}

	function fetch_cliente()
	{
		//$query = "SELECT * FROM cola_cafeteria.cliente ORDER BY id_cliente";
		$query = "SELECT * FROM cliente ORDER BY id_cliente";
		$statement = $this->connect->prepare($query);
		if($statement->execute())
		{
			while($row = $statement->fetch(PDO::FETCH_ASSOC))
			{
				$data[] = $row;
			}
			return $data;
		}
	}

	function insert_cliente()
	{
		if(isset($_POST["nombres"]))
		{
			$form_data = array(
				':id_cliente'		=>	$_POST["id_cliente"],
				':nombres'		=>	$_POST["nombres"],
				':apellidos'		=>	$_POST["apellidos"],
				':celular'		=>	$_POST["celular"],
				':nit'		=>	$_POST["nit"],
				':fecha_creacion'		=>	$_POST["fecha_creacion"]
			);
			// INSERT INTO cola_cafeteria.cliente 
			$query = "
			INSERT INTO cliente 
				(id_cliente, nombres, apellidos, celular, nit, fecha_creacion)
			 VALUES 
				(:id_cliente, :nombres, :apellidos, :celular, :nit, :fecha_creacion)
			";
			$statement = $this->connect->prepare($query);
			if($statement->execute($form_data))
			{
				$data[] = array(
					'success'	=>	'1'
				);
			}
			else
			{
				$data[] = array(
					'success'	=>	'0'
				);
			}
		}
		else
		{
			$data[] = array(
				'success'	=>	'0'
			);
		}
		return $data;
	}

	function fetch_single_cliente($id)
	{
		//$query = "SELECT * FROM cola_cafeteria.cliente WHERE id_hotel=$id";
		$query = "SELECT * FROM cliente WHERE id_cliente=$id";
		$statement = $this->connect->prepare($query);
		if($statement->execute())
		{
			foreach($statement->fetchAll() as $row)
			{
				$data['id_cliente'] = $row['id_cliente'];
				$data['nombres'] = $row['nombres'];
				$data['apellidos'] = $row['apellidos'];
				$data['celular'] = $row['celular'];
				$data['nit'] = $row['nit'];
				$data['fecha_creacion'] = $row['fecha_creacion'];
			}
			return $data;
		}
	}

	function update_cliente()
	{
		if(isset($_POST["nombre_hotel"]))
		{
			$form_data = array(
				':id_cliente'		=>	$_POST["id_cliente"],
				':nombres'		=>	$_POST["nombres"],
				':apellidos'		=>	$_POST["apellidos"],
				':celular'		=>	$_POST["celular"],
				':nit'		=>	$_POST["nit"]
			);
			$query = "
			UPDATE 
				cliente 
			SET 
				nombres  = :nombres, 
				apellidos= :apellidos ,
				celular  = :celular,
				nit = :nit
			WHERE id_cliente = :id_cliente
			";
			$statement = $this->connect->prepare($query);
			if($statement->execute($form_data))
			{
				$data[] = array(
					'success'	=>	'1'
				);
			}
			else
			{
				$data[] = array(
					'success'	=>	'0'
				);
			}
		}
		else
		{
			$data[] = array(
				'success'	=>	'0'
			);
		}
		return $data;
	}
	function delete_cliente($id)
	{
		$query = "Delete from cliente WHERE id_cliente = $id";
		$statement = $this->connect->prepare($query);
		if($statement->execute())
		{
			$data[] = array(
				'success'	=>	'1'
			);
		}
		else
		{
			$data[] = array(
				'success'	=>	'0'
			);
		}
		return $data;
	}
}

?>