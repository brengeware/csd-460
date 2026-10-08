package tags;

import java.io.IOException;

import jakarta.servlet.jsp.JspWriter;
import jakarta.servlet.jsp.PageContext;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;

public class NavigationBarTag extends SimpleTagSupport {
	
	@Override
	public void doTag() throws IOException {
		JspWriter out = getJspContext().getOut();
		// Gets the session
		PageContext pageContext = (PageContext) getJspContext();
		HttpSession session = pageContext.getSession();
		
		// Sets default login and register buttons
		String accountButtons = "<div class=\"button\"><a href=\"login.jsp\" class=\"login\">Login</a></div>\r\n" + 
				"<div class=\"button\"><a href=\"register.jsp\" class=\"register\">Register</a></div>";
		
		// If the user is logged in, replaces login and register buttons with logout button and welcome message
		if (session.getAttribute("loggedIn") != null) {
			if (session.getAttribute("loggedIn").equals("True")) {
			
			String welcomeName = (String) session.getAttribute("firstName");
			
	        accountButtons = "<div class=\"button\"><span>Welcome, " + welcomeName + "</span></div>\n" + 
				"<div class=\"button\"><a href=\"logout.jsp\" class=\"login\">Logout</a></div>";
			}
		}
	        
		// First part of the navigation bar
		String opening =
				"""
				<div class="navbar">
					<div class="logo">
		                <a href="index.jsp"><img src="logo.png" alt="Moffat Bay Logo"></a>
		                <a href="index.jsp">Moffat Bay <br>Resort</a>
		            </div>
		            <div class="navlink">
		                <a href="#">Book Your <br>Vacation</a>
		                <a href="#">View Your <br>Reservation</a>
		                <a href="#">Attractions</a>
		                <a href="#">About Us</a>
		                <a href="#">Contact Us</a>
		            </div>
		            <div class="navbutton">
				""";
		
		// Last part of the navigation bar (after buttons)
		String closing = """
				 </div>
        </div>
				""";

		// Displays the navigation bar
		out.print(opening);
		out.print(accountButtons);
		out.print(closing);
	}

}
