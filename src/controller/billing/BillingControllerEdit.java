package controller.billing;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserServiceFactory;

import controller.PMF;
import model.Access;
import model.Billing;
import model.Resource;
import model.Users;

@SuppressWarnings("serial")
public class BillingControllerEdit extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User user=UserServiceFactory.getUserService().getCurrentUser();
		PersistenceManager pm = PMF.get().getPersistenceManager();
		if(user==null){
			req.getRequestDispatcher("/user/login").forward(req, resp);
		}else{
			String query="SELECT FROM "+Users.class.getName()+" WHERE email=='"+user.getEmail()+"' && status==true";
			List<Users> users=(List<Users>)pm.newQuery(query).execute();
			if(users.isEmpty()){
				//ERROR NO EXISTE UN USUARIO O NO ESTA ACTIVO
				String codigoError="ERROR NO ES UN USUARIO REGRISTRADO O NO ESTA ACTIVO";
				req.setAttribute("error", codigoError);
				req.getRequestDispatcher("/WEB-INF/View/Users/error.jsp").forward(req, resp);
			}else{
				String query2="SELECT FROM "+Resource.class.getName()+" WHERE url=='"+req.getServletPath()+"' && status==true";
				List<Resource> resource=(List<Resource>)pm.newQuery(query2).execute();
				if(resource.isEmpty()){
					//ERROR NO EXISTE UN RECURSO O NO ESTA ACTIVO
					String codigoError="ERROR NO EXISTE UN RECURSO O NO ESTA ACTIVO";
					req.setAttribute("error", codigoError);
					req.getRequestDispatcher("/WEB-INF/View/Users/error.jsp").forward(req, resp);
				}else{
					String query3="SELECT FROM "+Access.class.getName()+" WHERE idRole=="+users.get(0).getIdRole()+" && idUrl=="+resource.get(0).getId()+" && status==true";
					List<Access> access=(List<Access>)pm.newQuery(query3).execute();
					if(access.isEmpty()){
						//ERROR NO EXISTE UN ACCESO O NO ESTA ACTIVO
						String codigoError="ERROR NO EXISTE UN ACCESO O NO ESTA ACTIVO";
						req.setAttribute("error", codigoError);
						req.getRequestDispatcher("/WEB-INF/View/Users/error.jsp").forward(req, resp);
					}else{
						//Esto utlimo es el servlet Original
						Billing billing = pm.getObjectById(Billing.class, Long.parseLong(req.getParameter("id")));
						pm.close();
						req.setAttribute("billing", billing);
						RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/WEB-INF/View/Billing/edit.jsp");
						rd.forward(req, resp);
					}
				}
			}
		}
	}
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Billing billing = pm.getObjectById(Billing.class, Long.parseLong(req.getParameter("id")));
		billing.setDateIn();
		billing.setCustomer(req.getParameter("customer"));
		billing.setAddress(req.getParameter("address"));
		billing.setDescriptionProduct(req.getParameter("descriptionproduct"));
		billing.setUnitPriceProduct(Double.parseDouble(req.getParameter("unitpriceproduct")));
		billing.setMountProduct(Double.parseDouble(req.getParameter("mountProduct")));
		billing.setTotal();
		pm.close();
		resp.sendRedirect("/billing/view?id="+req.getParameter("id"));//Enviar al ViewController
	}
}