<!DOCTYPE html>
<html>
	<head>
		<title>Clientes</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	</head>
	<body>
		<div class="container">
			<br />
			
			<h3 align="center">CAFETERIA COLAB - CLIENTES</h3>
			<br />
			<div align="right" style="margin-bottom:5px;">
				<button type="button" name="add_button" id="add_button" class="btn btn-success btn-xs">Agregar</button>
			</div>

			<div class="table-responsive">
				<table class="table table-bordered table-striped">
					<thead>
						<tr>
							<th>ID</th>
							<th>Nombres</th>
							<th>Apellidos</th>
							<th>Celular</th>
							<th>NIT</th>
							<th>Fecha Creacion</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</div>
	</body>
</html>

<div id="apicrudModal" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<form method="post" id="api_crud_form">
				<div class="modal-header">
		        	<button type="button" class="close" data-dismiss="modal">&times;</button>
		        	<h4 class="modal-title">Insertar Cliente</h4>
		      	</div>
		      	<div class="modal-body">
		      		<div class="form-group">
			        	<label>Ingrese DPI del cliente</label>
			        	<input type="text" name="id_cliente" id="id_cliente" class="form-control" />
			        </div>
		      		<div class="form-group">
			        	<label>Ingrese los nombres del cliente</label>
			        	<input type="text" name="nombres" id="nombres" class="form-control" />
			        </div>
			        <div class="form-group">
			        	<label>Ingrese los apellidos del cliente</label>
			        	<input type="text" name="apellidos" id="apellidos" class="form-control" />
			        </div>
			        <div class="form-group">
			        	<label>Ingrese el celular del cliente</label>
			        	<input type="text" name="celular" id="celular" class="form-control" />
			        </div>
			        <div class="form-group">
			        	<label>Ingrese el nit del cliente</label>
			        	<input type="text" name="nit" id="nits" class="form-control" />
			        </div>
			        <div class="form-group">
			        	<label>Ingrese Fecha</label>
			        	<input type="datetime-local" name="fecha_creacion" id="fecha_creacion" class="form-control" />
			        </div>
			    </div>
			    <div class="modal-footer">
			    	<input type="text" name="hidden_id" id="hidden_id" />
			    	<input type="hidden" name="action" id="action" value="insert_cliente" />
			    	<input type="submit" name="button_action" id="button_action" class="btn btn-info" value="Insert_cliente" />
			    	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      		</div>
			</form>
		</div>
  	</div>
</div>


<script type="text/javascript">
$(document).ready(function(){

	fetch_data();

	function fetch_data()
	{
		$.ajax({
			url:"fetch.php",
			success:function(data)
			{
				$('tbody').html(data);
			}
		})
	}

	$('#add_button').click(function(){
		$('#action').val('insert_cliente');
		$('#button_action').val('Insert_cliente');
		$('.modal-title').text('Agregar Información de Cliente');
		$('#apicrudModal').modal('show');
	});

	$('#api_crud_form').on('submit', function(event){
		event.preventDefault();
		if($('#nombres').val() == '')
		{
			alert("Ingrese algun nombre");
		}
		else if($('#apellidos').val() == '')
		{
			alert("Ingrese algun apellido");
		}
		else if($('#celular').val() == '')
		{
			alert("Ingrese algun celular");
		}
		else
		{
			var form_data = $(this).serialize();
			$.ajax({
				url:"action.php",
				method:"POST",
				data:form_data,
				success:function(data)
				{
					fetch_data();
					$('#api_crud_form')[0].reset();
					$('#apicrudModal').modal('hide');
					if(data == 'insert_cliente')
					{
						alert("Informacion insertada usando APIS");
					}
					if(data == 'update_cliente')
					{
						alert("Informacion actualizada usando APIS");
					}
				}
			});
		}
	});

	$(document).on('click', '.edit', function(){
		var id = $(this).attr('id');
		var action = 'fetch_single_cliente';	
		$.ajax({
			url:"action.php",
			method:"POST",
			data:{id:id, action:action},
			dataType:"json",
			success:function(data)
			{
				$('#id_cliente').val(data.id_cliente);
				$('#hidden_id').val(data.id_cliente);
				$('#nombres').val(data.nombres);
				$('#apellidos').val(data.apellidos);
				$('#celular').val(data.celular);
				$('#nit').val(data.nit);
				$('#action').val('update_cliente');
				$('#button_action').val('Update_cliente');
				$('.modal-title').text('Modificar Informacion de Cliente');
				$('#apicrudModal').modal('show');
			}
		})
	});

	$(document).on('click', '.delete', function(){
		var id = $(this).attr("id");
		var action = 'delete_cliente';
		if(confirm("Seguro que quiere eliminar al cliente con las APIS?"))
		{
			$.ajax({
				url:"action.php",
				method:"POST",
				data:{id:id, action:action},
				success:function(data)
				{
					fetch_data();
					alert("Informacion eliminada usando API");
				}
			});
		}
	});

});
</script>