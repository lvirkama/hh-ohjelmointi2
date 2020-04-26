<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Asiakaslistaus</title>
<style>
thead>tr>th {
	background-color: lightgreen;
}

tbody>tr:nth-child(even) {
	background-color: lightgray;
}

</style>
</head>
<body>
<table id="listaus">
	<thead>
		<tr>
			<th colspan="2" style="text-align:right">Hakusana:</th>
			<th><input type="text" id="hakukentta" /></th>
			<th><input type="button" id="hakunappi" value="Hae" /></th>
		</tr>
		<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sposti</th>							
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
<script>
$(document).ready(function(){
	haeAsiakkaat();
	$("#hakunappi").click(function(){		
		haeAsiakkaat();
	});
	$(document.body).on("keydown", function(event){
		  if(event.which==13){ //Enteriä painettu, ajetaan haku
			  haeAsiakkaat();
		  }
	});
	$("#hakukentta").focus(); 
});
function haeAsiakkaat() {
	$("#listaus tbody").empty();
	$.ajax({url:encodeURI("Asiakkaat/"+$("#hakukentta").val()), type:"GET", dataType:"json", success:function(result){//Funktio palauttaa tiedot json-objektina		
		$.each(result.asiakkaat, function(i, field){  
        	var htmlStr;
        	htmlStr+="<tr>";
        	htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.sukunimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sposti+"</td>";  
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        });	
    }});		
}


</script>
</body>
</html>