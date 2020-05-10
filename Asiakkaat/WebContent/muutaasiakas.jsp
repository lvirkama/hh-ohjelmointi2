<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<script src="scripts/main.js"></script>
<title>Asiakkaan muutos</title>
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
<form id="asiakasmuutos">
<table>
	<thead>
		<tr>
			<th colspan="2" style="text-align:left">Asiakkaan muuttaminen</th>
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
	<td><input type="submit" id="tallenna" value="Muuta"></td>
	</tr>
	</tbody>
</table>
<input type="hidden" name="asiakasid" id="asiakasid">
</form>
<span id="ilmo"></span>
</body>
<script>
$(document).ready(function(){
	var asiakasid = requestURLParam("id"); //Funktio löytyy scripts/main.js 	
	$.ajax({url:"Asiakkaat/haeyksi/"+asiakasid, type:"GET", dataType:"json", success:function(result){	
		$("#asiakasid").val(result.asiakasid);		
		$("#etunimi").val(result.etunimi);	
		$("#sukunimi").val(result.sukunimi);
		$("#puhelin").val(result.puhelin);
		$("#sposti").val(result.sposti);			
    }});	
	$("#asiakasmuutos").validate({
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
				email: "Väärä muoto"
			}
		},			
		submitHandler: function(form) {	
			muutaTiedot();
		}		
	}); 	
});
//funktio tietojen lisäämistä varten. Kutsutaan backin POST-metodia ja välitetään kutsun mukana uudet tiedot json-stringinä.
//POST /autot/
function muutaTiedot(){	
	var formJsonStr = formDataJsonStr($("#asiakasmuutos").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	$.ajax({url:"Asiakkaat", data:formJsonStr, type:"PUT", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		if(result.response==1){
      	$("#ilmo").html("Asiakkaan muuttaminen epäonnistui.");
      }else if(result.response==0){			
      	$("#ilmo").html("Asiakkaan muuttaminen onnistui.");
		}
  }});	
}
</script>
</html>