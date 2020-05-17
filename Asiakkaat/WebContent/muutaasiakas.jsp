<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
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
<form id="asiakasmuutos" onsubmit="muutaTiedot();return false;">
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
var asiakasid = requestURLParam("id");
fetch("Asiakkaat/haeyksi/" + asiakasid,{
    method: 'GET'	      
  })
.then( function (response) {
	return response.json()
})
.then( function (responseJson) {	
	document.getElementById("asiakasid").value = responseJson.asiakasid;		
	document.getElementById("etunimi").value = responseJson.etunimi;	
	document.getElementById("sukunimi").value = responseJson.sukunimi;	
	document.getElementById("puhelin").value = responseJson.puhelin;	
	document.getElementById("sposti").value = responseJson.sposti;	
});	
//funktio tietojen lisäämistä varten. Kutsutaan backin POST-metodia ja välitetään kutsun mukana uudet tiedot json-stringinä.
//POST /autot/
function muutaTiedot(){	
	var ilmo="";
	if (document.getElementById("etunimi").value.length <= 2) {
		ilmo = "Etunimi liian lyhyt (tulee olla yli 2 merkkiä)";
	} else if (document.getElementById("sukunimi").value.length <= 2) {
		ilmo = "Sukunimi liian lyhyt (tulee olla yli 2 merkkiä)";
	} else if (document.getElementById("puhelin").value.length <= 6) {
		ilmo = "Puhelinnumero liian lyhyt (tulee olla yli 6 merkkiä)";
	} else if (/^[^.@\s]+(\.[^.@\s]+)*@[^.@\s]+(\.[^.@\s]+)*$/.test(document.getElementById("sposti").value) != true) {
		ilmo = "Sähköpostiosoite väärän muotoinen";
	}
	if (ilmo != '') {
		document.getElementById("ilmo").innerHTML = ilmo;
		setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
		return;
	}
	document.getElementById("asiakasid").value = siivoa(document.getElementById("asiakasid").value);		
	document.getElementById("etunimi").value = siivoa(document.getElementById("etunimi").value);
	document.getElementById("sukunimi").value = siivoa(document.getElementById("sukunimi").value);
	document.getElementById("puhelin").value = siivoa(document.getElementById("puhelin").value);
	document.getElementById("sposti").value = siivoa(document.getElementById("sposti").value);

	var formJsonStr = formDataToJSON(document.getElementById("asiakasmuutos")); //muutetaan lomakkeen tiedot json-stringiksi
	console.log(formJsonStr);

	fetch("Asiakkaat",{
	      method: 'PUT',
	      body:formJsonStr
	    })
	.then( function (response) {
		return response.json();
	})
	.then( function (responseJson) {	
		var vastaus = responseJson.response;		
		if(vastaus==1){
			document.getElementById("ilmo").innerHTML= "Asiakkaan muuttaminen epäonnistui.";
      	}else if(vastaus==0){	        	
      		document.getElementById("ilmo").innerHTML= "Asiakkaan muuttaminen onnistui.";			      	
		}	
		setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
	});	
}
</script>
</html>