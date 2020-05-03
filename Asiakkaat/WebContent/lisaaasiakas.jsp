<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<script src="scripts/main.js"></script>
<title>Asiakkaan lis�ys</title>
<style>
thead>tr>th {
	background-color: lightgreen;
	min-width: 100px;
}
a {
	text-decoration: none;
}
</style>
</head>
<body>
<form id="asiakaslisays">
<table>
	<thead>
		<tr>
			<th colspan="2" style="text-align:left">Asiakkaan lis�ys</th>
			<th colspan="3" style="text-align:right"><a href="listaaasiakkaat.jsp">Takaisin listaukseen</a></th>
		</tr>
		<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sposti</th>
			<th></th>							
		</tr>
	</thead>
	<tbody>
	<tr>
	<td><input type="text" name="etunimi" id="etunimi"></td>
	<td><input type="text" name="sukunimi" id="sukunimi"></td>
	<td><input type="text" name="puhelin" id="puhelin"></td>
	<td><input type="text" name="sposti" id="sposti"></td>
	<td><input type="submit" id="tallenna" value="Lis��"></td>
	</tr>
	</tbody>
</table>
</form>
<span id="ilmo"></span>
</body>
<script>
$(document).ready(function(){
	$("#asiakaslisays").validate({
		rules: {
			etunimi:  {
				required: true,
				minlength: 2				
			},	
			sukunimi:  {
				required: true,
				minlength: 2	
			},
			puhelin:  {
				required: true,
				minlength: 6
			},	
			sposti:  {
				required: true,
				email: true
			}	
		},
		messages: {
			etunimi: {     
				required: "Puuttuu",
				minlength: "Liian lyhyt (2)"		
			},
			sukunimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt (2)"
			},
			puhelin: {
				required: "Puuttuu",
				minlength: "Liian lyhyt (6)"
			},
			sposti: {
				required: "Puuttuu",
				email: "V��r� muoto"
			}
		},			
		submitHandler: function(form) {	
			lisaaTiedot();
		}		
	}); 	
});
//funktio tietojen lis��mist� varten. Kutsutaan backin POST-metodia ja v�litet��n kutsun mukana uudet tiedot json-stringin�.
//POST /autot/
function lisaaTiedot(){	
	var formJsonStr = formDataJsonStr($("#asiakaslisays").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	$.ajax({url:"Asiakkaat", data:formJsonStr, type:"POST", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		if(result.response==1){
      	$("#ilmo").html("Asiakkaan lis��minen ep�onnistui.");
      }else if(result.response==0){			
      	$("#ilmo").html("Asiakkaan lis��minen onnistui.");
      	$("#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
		}
  }});	
}
</script>
</html>