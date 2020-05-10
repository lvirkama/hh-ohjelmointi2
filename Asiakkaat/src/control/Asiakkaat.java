package control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import model.Asiakas;
import model.dao.Dao;

import java.io.PrintWriter;
import java.util.ArrayList;
/**
 * Servlet implementation class Asiakkaat
 */
@WebServlet("/Asiakkaat/*")
public class Asiakkaat extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Asiakkaat() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pathInfo = request.getPathInfo();
		
		Dao dao = new Dao();
		ArrayList<Asiakas> asiakkaat;
		String strJSON = "";
		if (pathInfo == null) {
			asiakkaat = dao.lueKaikki("%");
			strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString();
		}
		else if (pathInfo.indexOf("haeyksi") != -1) {
			String asiakasid = pathInfo.replace("/haeyksi/","");
			try {
				Asiakas asiakas = dao.etsiAsiakas(Integer.parseInt(asiakasid));
				JSONObject JSON = new JSONObject();
				JSON.put("asiakasid", asiakas.getAsiakasID());
				JSON.put("etunimi", asiakas.getEtunimi());
				JSON.put("sukunimi", asiakas.getSukunimi());
				JSON.put("sposti", asiakas.getSposti());
				JSON.put("puhelin", asiakas.getPuhelin());
				strJSON = JSON.toString();
			} catch (Exception nfe) {
				strJSON = "{}";
			}
		}
		else {
			String hakusana = pathInfo.replace("/", "");
			asiakkaat = dao.lueKaikki(hakusana);
			strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString();
		}

		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		out.println(strJSON);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONObject json = new JsonStrToObj().convert(request);
		Asiakas asiakas = new Asiakas();
		asiakas.setEtunimi(json.getString("etunimi"));
		asiakas.setSukunimi(json.getString("sukunimi"));
		asiakas.setPuhelin(json.getString("puhelin"));
		asiakas.setSposti(json.getString("sposti"));
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();
		if (dao.lisaaAsiakas(asiakas)) {
			out.println("{\"response\":0}");
		}
		else {
			out.println("{\"response\":1}");
		}
	}

	@Override
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String hakusana = request.getPathInfo().replace("/", "");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();
		try {
			int asiakasid = Integer.parseInt(hakusana);
			if (dao.poistaAsiakas(asiakasid)) {
				out.println("{\"response\":0}");
			}
		} catch (NumberFormatException e) {
			out.println("{\"response\":1}");
		} 
	}

	@Override
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONObject json = new JsonStrToObj().convert(request);
		Asiakas asiakas = new Asiakas();
		asiakas.setEtunimi(json.getString("etunimi"));
		asiakas.setSukunimi(json.getString("sukunimi"));
		asiakas.setPuhelin(json.getString("puhelin"));
		asiakas.setSposti(json.getString("sposti"));
		asiakas.setAsiakasID(Integer.parseInt(json.getString("asiakasid")));
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();
		if (dao.muutaAsiakas(asiakas)) {
			out.println("{\"response\":0}");
		}
		else {
			out.println("{\"response\":1}");
		}		
		System.err.println("doPut");
	}
	
}
