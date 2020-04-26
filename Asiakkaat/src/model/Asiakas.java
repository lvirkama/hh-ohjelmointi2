package model;

public class Asiakas {
	private String etunimi,sukunimi,puhelin,sposti;
	private int asiakasID;
	public String getEtunimi() {
		return etunimi;
	}

	public void setEtunimi(String etunimi) {
		this.etunimi = etunimi;
	}

	public String getSukunimi() {
		return sukunimi;
	}

	public void setSukunimi(String sukunimi) {
		this.sukunimi = sukunimi;
	}

	public String getPuhelin() {
		return puhelin;
	}

	public void setPuhelin(String puhelin) {
		this.puhelin = puhelin;
	}

	public String getSposti() {
		return sposti;
	}

	public void setSposti(String sposti) {
		this.sposti = sposti;
	}

	public int getAsiakasID() {
		return asiakasID;
	}

	public void setAsiakasID(int asiakasID) {
		this.asiakasID = asiakasID;
	}
}
