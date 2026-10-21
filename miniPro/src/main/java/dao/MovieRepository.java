package dao;

import java.sql.*;
import java.util.ArrayList;

import dto.Movie;

public class MovieRepository {
	
	private static final String ResultSet = null;
	private ArrayList<Movie> movieList = new ArrayList<>();
	
	
	public ArrayList<Movie> getMovieList(){
		
		Connection conn = null;
		Statement stmt = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mini_project","mini","mini123");
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select m.movie_id, title, content, rating, release_year, company, director, genre, actors, schedule_id, s.screen_id, start_time, price, screen_name, seat, img_src\r\n"
					+ "from movies as m left join schedule as s on m.movie_id = s.movie_id left join screen sc on s.screen_id = sc.screen_id ORDER BY s.start_time ASC;\r\n"
					+ "");
			
			while(rs.next()) {
				Movie movie = new Movie();
				movie.setMovieId(rs.getString("m.movie_id"));
				movie.setTitle(rs.getString("title"));
				movie.setContent(rs.getString("content"));
				movie.setRating(rs.getString("rating"));
				movie.setRelease(rs.getInt("release_year"));
				movie.setCompany(rs.getString("company"));
				movie.setDirector(rs.getString("director"));
				movie.setGenre(rs.getString("genre"));
				movie.setImg_src(rs.getString("img_src"));
				movie.setActors(rs.getString("actors"));
				
				movie.setScheduleId(rs.getInt("schedule_id"));
				movie.setScreenId(rs.getString("s.screen_id"));
				movie.setStartTime(rs.getString("start_time"));
				movie.setPrice(rs.getInt("price"));
				
				movie.setScreenName(rs.getString("screen_name"));
				movie.setSeat(rs.getInt("seat"));
				
				
				
				movieList.add(movie);
			}
			
			stmt.close();
			conn.close();
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		return movieList;

	}
	
	
	public Movie getMovieInfo(String movieId) {
		Movie movie = new Movie();
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mini_project","mini","mini123");
			Statement stmt = conn.createStatement();
			
			ResultSet rs = stmt.executeQuery("select m.movie_id, title, content, rating, release_year, company, director, genre, actors, schedule_id, s.screen_id, start_time, price, screen_name, seat, img_src "
					+ "from movies as m left join schedule as s on m.movie_id = s.movie_id left join screen sc on s.screen_id = sc.screen_id "
					+ "where m.movie_id = '"+ movieId +"'");
			
			if(rs.next()) {
				movie.setMovieId(rs.getString("m.movie_id"));
				movie.setTitle(rs.getString("title"));
				movie.setContent(rs.getString("content"));
				movie.setRating(rs.getString("rating"));
				movie.setRelease(rs.getInt("release_year"));
				movie.setCompany(rs.getString("company"));
				movie.setDirector(rs.getString("director"));
				movie.setGenre(rs.getString("genre"));
				movie.setImg_src(rs.getString("img_src"));
				movie.setActors(rs.getString("actors"));
				
				movie.setScheduleId(rs.getInt("schedule_id"));
				movie.setScreenId(rs.getString("s.screen_id"));
				movie.setStartTime(rs.getString("start_time"));
				movie.setPrice(rs.getInt("price"));
				
				movie.setScreenName(rs.getString("screen_name"));
				movie.setSeat(rs.getInt("seat"));
			}
			
			stmt.close();
			conn.close();
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return movie;
	}
	
	public void addCustomer(Movie movie) {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mini_project","mini","mini123");
			Statement stmt = conn.createStatement();
			
			String sql = "INSERT INTO reservation(schedule_id, user_id, seat_num) VALUES('"+ movie.getScheduleId() +"','" + movie.getUserId() + "','" + movie.getSeatNum() + "')";
			stmt.executeUpdate(sql);
			
			
			stmt.close();
			conn.close();
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		
	}
	
	public ArrayList<String> reservedSeat(int scheduleId){
		ArrayList<String> reservedSeat = new ArrayList<>();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mini_project","mini","mini123");
			Statement stmt = conn.createStatement();
			
			String sql = ("SELECT seat_num FROM reservation WHERE schedule_id = " + scheduleId);
			ResultSet rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				String seatNumStr = rs.getString("seat_num");
				if(seatNumStr != null && !seatNumStr.isEmpty()) {
					String[] seats = seatNumStr.split(",");
					for(String seat : seats) {
						reservedSeat.add(seat);
					}
				}
			}
			
			stmt.close();
			conn.close();
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		
		
		return reservedSeat;
	}
	
	public ArrayList<Movie> customerList(){
		ArrayList<Movie> customerList = new ArrayList<>();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mini_project","mini","mini123");
			Statement stmt = conn.createStatement();
			
			String sql = "SELECT r.reservation_id, r.user_id, r.seat_num, r.reservation_time, m.title, s.start_time, m.movie_id, sc.screen_name\r\n"
					+ "FROM reservation r JOIN schedule s ON r.schedule_id = s.schedule_id JOIN movies m ON s.movie_id = m.movie_id LEFT JOIN screen sc ON s.screen_id = sc.screen_id\r\n"
					+ "ORDER BY r.reservation_id DESC";
			
			ResultSet rs = stmt.executeQuery(sql);	
			
			while(rs.next()) {
				Movie customer = new Movie();
				customer.setReservationId(Integer.parseInt(rs.getString("reservation_id")));
				customer.setTitle(rs.getString("title"));
				customer.setStartTime(rs.getString("start_time"));
				customer.setUserId(rs.getString("user_id"));
				customer.setSeatNum(rs.getString("seat_num"));
				customer.setScreenName(rs.getString("screen_name"));
				customer.setReservationTime(rs.getString("reservation_time"));
				customer.setMovieId(rs.getString("movie_id"));
				
				customerList.add(customer);
				
			}
			
			stmt.close();
			conn.close();
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		
		return customerList;
	}
	

}
