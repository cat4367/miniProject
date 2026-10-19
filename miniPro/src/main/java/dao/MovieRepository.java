package dao;

import java.sql.*;
import java.util.ArrayList;

import dto.Movie;

public class MovieRepository {
	
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
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return movie;
	}

}
