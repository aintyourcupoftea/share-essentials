package businesslogic;

import java.io.PrintWriter;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@WebServlet("/booking-service")
public class BookingService extends HttpServlet{

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res){
		String name=req.getParameter("name");
		try {
			PrintWriter out=res.getWriter();
			out.print(name);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	
	
}
