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
	min-width: 100px;
}

tbody>tr:nth-child(even) {
	background-color: lightgray;
}
a {
	text-decoration: none;
}
.poista{
	color: red;
	text-decoration: underline;
	cursor: pointer;	
}

</style>
</head>
<body>
<table id="listaus">
	<thead>
		<tr>
			<th colspan="5" style="text-align:right"><a href="lisaaasiakas.jsp">Lisää asiakas</a></th>
		</tr>
		<tr>
			<th colspan="2" style="text-align:right">Hakusana:</th>
			<th><input type="text" id="hakukentta" /></th>
			<th colspan="2"><input type="button" id="hakunappi" value="Hae" /></th>
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
	</tbody>
</table>
<span id="ilmo"></span>
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
        	htmlStr+="<tr id='rivi_"+field.asiakasID+"'>";
        	htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.sukunimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sposti+"</td>";  
        	htmlStr+="<td><span class='poista' onclick=poista("+field.asiakasID+",'"+field.etunimi+"','"+field.sukunimi+"')>Poista</span></td>";
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        });	
    }});		
}

function poista(asiakasid, etunimi, sukunimi){
	if(confirm("Poista asiakas " + etunimi +" "+sukunimi+"?")){
		$.ajax({url:encodeURI("Asiakkaat/"+asiakasid), type:"DELETE", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}
	        if(result.response==1){
	        	$("#ilmo").html("Asiakkaan poisto epäonnistui.");
	        }else if(result.response==0){
	        	alert(asiakasid);
	        	alert("#rivi_"+asiakasid);
	        	$("#rivi_"+asiakasid).css("background-color", "red"); //Värjätään poistetun asiakkaan rivi
	        	alert("Asiakkaan  " + etunimi +" "+sukunimi+" poisto onnistui.");
				haeAsiakkaat();        	
			}
	    }});
	}
}


</script>
</body>
</html>