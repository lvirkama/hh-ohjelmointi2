package model.dao;

import java.sql.*;
import java.util.ArrayList;

import model.Asiakas;

public class Dao {
	private String db = "Myynti.sqlite";
	
	public Connection yhdista() {
		try {
			Class.forName("org.sqlite.JDBC");
		} catch (Exception e) {
			return null;
		}
		String path = System.getProperty("catalina.base");
		path = path.substring(0, path.indexOf(".metadata")).replace("\\","/");
				
		String connString = "jdbc:sqlite:"+path+db;
		try {
			return DriverManager.getConnection(connString);
		} catch (Exception e) {
			return null;
		}		
	}
	
	public ArrayList<Asiakas> lueKaikki() {
		Connection con = yhdista();
		ArrayList<Asiakas> asiakkaat = new ArrayList<Asiakas>();
		if (con != null) {
			try {
				PreparedStatement ps = con.prepareStatement("SELECT * FROM asiakkaat");
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					Asiakas asiakas = new Asiakas();
					asiakas.setAsiakasID(rs.getInt("asiakas_ID"));
					asiakas.setEtunimi(rs.getString("etunimi"));
					asiakas.setSukunimi(rs.getString("sukunimi"));
					asiakas.setSposti(rs.getString("sposti"));
					asiakas.setPuhelin(rs.getString("puhelin"));
					asiakkaat.add(asiakas);
				}
			} catch (SQLException e) {
			} finally {
				try {
					con.close();
				} catch (Exception e) { }
			}
		}
		return asiakkaat;
	}
}
