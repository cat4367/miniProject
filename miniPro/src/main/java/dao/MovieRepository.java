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
			ResultSet rs = stmt.executeQuery("select * from movies");
			
			while(rs.next()) {
				Movie movie = new Movie();
				movie.setTitle(rs.getString("title"));
				movie.setContent(rs.getString("content"));
				movie.setRating(rs.getString("rating"));
				movie.setRelease(rs.getInt("release_year"));
				movie.setDirector(rs.getString("director"));
				movie.setGenre(rs.getString("genre"));
				movie.setImg_src(rs.getString("img_src"));
				movie.setActors(rs.getString("actors"));
				
				movieList.add(movie);
			}
			
			stmt.close();
			conn.close();
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		return movieList;

	}

}
