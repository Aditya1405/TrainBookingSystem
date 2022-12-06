package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import com.mysql.cj.xdevapi.JsonArray;

/**
 * Servlet implementation class BookTicketServlet
 */
public class BookTicketServlet extends HttpServlet {
	
	
	private static final long serialVersionUID = 1L;

	private String jdbcURL = "jdbc:mysql://localhost:3306/trainbookingsystem?allowPublicKeyRetrieval=true&useSSL=false";
	private String jdbcUsername = "root";
	private String jdbcPassword = "root";

	// ipno == json array size coming from addpass.jsp
	private int ipno;
	// this we need static
	private static int itno;
	private static int pnr;
	private static String seatClass;
	// not static as when the submit button is pressed this page is refreshed
	// destroying all non static fields
	private int Availability_of_seats;
	private int General_seats;
	private int AC_seats;
	private int Fare;

	// ================(1) do get () triggered when book now is pressed from
	// booking. jsp ========================

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String tid = req.getParameter("tid");
		String tno = req.getParameter("tno");
		String seatType = req.getParameter("c");
		System.out.println("tid = "+tid+"tno ="+tno+" st = "+seatType);
		this.itno = Integer.valueOf(tno);
		
		SearchServlet s= new SearchServlet();
		Train trainInfo = s.getTrainInfo(this.itno);
		
		if (seatType.matches("AC")) {
			this.seatClass = "A";
			this.Fare=trainInfo.getFareAC();
		} else {
			this.seatClass = "G";
			this.Fare=trainInfo.getNACSeat();
		}
		System.out.println("fare"+this.Fare);
		
		// train no. in int
		//this.itno = Integer.valueOf(tno);
		
		RequestDispatcher dispatcher = null;
		req.setAttribute("fare", this.Fare);
		dispatcher = req.getRequestDispatcher("AddPasssenger.jsp");
		dispatcher.forward(req, resp);

	}

	// -------------connection------------------

	protected Connection getConnection() {
		Connection connection = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return connection;
	}

	// =============== get seat status ========== req when we are updating the train
	// seat before booking
	public void getSeatStatus() throws SQLException {
		try (Connection connection = getConnection();
				// insert
				PreparedStatement statement = connection.prepareStatement(
						"SELECT Availability_of_seats, General_seats, AC_seats FROM train where Train_no=?;");) {

			statement.setInt(1, itno);
			ResultSet rs = statement.executeQuery();
			if (rs.next()) {
				this.Availability_of_seats = rs.getInt(1);
				this.General_seats = rs.getInt(2);
				this.AC_seats = rs.getInt(3);

			}
		}

	}

	// ===================change train's seat availability ======== to be called
	// before booking ==============================

	public boolean updateTrain() throws SQLException {

		boolean rowUpdated;
		// true for Ac and false for NAC

		// boolean seatType=this.seatClass.matches("A")?true:false;
		// System.out.println("total seat = "+t.getAvailSeat()+" ac = "+t.getACSeat()+"
		// NAC = "+t.getNACSeat()+" Is AC = "+seatType);
		try (Connection connection = getConnection();
				PreparedStatement statement = connection.prepareStatement(
						"update train set Availability_of_seats = ?, General_seats = ?, AC_seats= ? where Train_no = ?;");) {
			statement.setInt(1, this.Availability_of_seats - this.ipno);
			
			System.out.println("seat = "+this.seatClass+" ac-gen = "+(this.AC_seats - this.ipno));
			if (this.seatClass.matches("A") && (this.AC_seats - this.ipno) >= 0) {

				// true for ac
				statement.setInt(2, this.General_seats);
				statement.setInt(3, this.AC_seats - this.ipno);
			} else if (this.seatClass.matches("G") &&( this.General_seats - this.ipno) >= 0) {
				// inc non ac seat
				statement.setInt(2, this.General_seats - this.ipno);
				// dont increment ac seat
				statement.setInt(3, this.AC_seats);
			} else {
				System.out.println("false");
				return false;
			}
			statement.setInt(4, this.itno);
			rowUpdated = statement.executeUpdate() > 0;
		}

		return rowUpdated;
	}
	// ==================book ticket by updating passenger status to
	// 1======================

	public boolean BookTicket(Ticket t) throws SQLException {
		boolean rowUpdated;
		try (Connection connection = getConnection();
				// insert
				PreparedStatement statement = connection.prepareStatement(
						"INSERT INTO passenger (`User_id`,`Passenger_name`,`Gender`,`Reservation_status`,`PNR`,`Train_no`,`SeatType`) VALUES (?,?,?,?,?,?,?);");) {
			// System.out.println("updated USer:"+statement);
			statement.setInt(1, t.getuid());
			statement.setString(2, t.getpName());
			statement.setString(3, t.getpGender());
			// 1 means booked == already set earlier
			statement.setInt(4, t.getStatus());
			statement.setInt(5, t.getpnr());
			statement.setInt(6, t.getId());
			statement.setString(7, t.getpSeatType());

			rowUpdated = statement.executeUpdate() > 0;
		}

		return rowUpdated;
	}

	// ===============get me last pnr so that we can create a new one from that by
	// +1================
	public void getLastPNR() throws SQLException {
		try (Connection connection = getConnection();
				// insert
				PreparedStatement statement = connection
						.prepareStatement("SELECT PNR FROM passenger order by PNR desc limit 1;");) {
			ResultSet rs = statement.executeQuery();
			if (rs.next()) {
				this.pnr = rs.getInt(1);
				System.out.println("pnr" + this.pnr);
			}
		}

	}

	// ===============do post executed after addpass.jsp is submitted
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = null;
		HttpSession session = request.getSession();

		// =============================================addpass.js form=================
		// this will give you name and gender
		String arr = request.getParameter("array");

		JSONObject jsonObj = new JSONObject(arr);

		// Fetching nested Json using JSONArray
		JSONArray arrObj = jsonObj.getJSONArray("data");
		
		this.ipno = arrObj.length();
		// ===========================================

		// ============= **** main code *** ====================

		// TODO Auto-generated method stub
		try {
			getLastPNR();
			getSeatStatus();

		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		int id = (int) session.getAttribute("id");
		// to store all tickets for new passengers
		ArrayList<Ticket> pl = new ArrayList<>();
		for (int i = 0; i < arrObj.length(); i++) {

			Ticket t = new Ticket();

			t.setp_Name(arrObj.getJSONObject(i).getString("name"));
			t.setp_Gender(arrObj.getJSONObject(i).getString("gender"));
			t.setp_ResStatus(1);
			t.setpSeatType(this.seatClass);
			t.setu_Id(id);
			t.setId(itno);
			// add pnr
			t.setp_PNR(++this.pnr);
			System.out.println(t.getpName() + " " + t.getpGender() + " " + t.getpnr() + " " + t.getStatus() + " "
					+ t.getpSeatType());
			pl.add(t);

		}

		try {

			boolean b = updateTrain();
			if (b) {
				System.out.println("updateTrain = " + b);
				for (int i = 0; i < pl.size(); i++) {

					boolean ba = BookTicket(pl.get(i));
					System.out.println("update = " + ba);

				}
				request.setAttribute("status", "success");
			} else {
				request.setAttribute("status", "seatFull");
			}
			dispatcher = request.getRequestDispatcher("booking.jsp");
			dispatcher.forward(request, response);

		} catch (SQLException e1) {
			// TODO Auto-generated catch block

			e1.printStackTrace();
			request.setAttribute("status", "failed");
			dispatcher = request.getRequestDispatcher("booking.jsp");
			dispatcher.forward(request, response);

		}

	}

}
