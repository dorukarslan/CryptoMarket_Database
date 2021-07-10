








package Database;

import java.sql.*;
import java.util.InputMismatchException;
import java.util.Scanner;

public class dbtasks {
	private static Connection connect = null;
	private static Statement statement = null;

	private static ResultSet resultSet = null;
	private static int resultSet2;
	private static int resultSet3;

	final private static String host = "Write hostname here";
	final private static String user = "Write usernamev here";
	final private static String password = "Write password here";

	public static void main(String[] args) {
		ResultSet resultSet_users1 = null;
		ResultSet resultSet_users2 = null;
		try {
			Connection connection = DriverManager.getConnection(host, user, password);
			statement = connection.createStatement();
		} catch (Exception e) {
			System.out.println("no");
			e.printStackTrace();
		}

		try {
			Connection connection = DriverManager.getConnection(host, user, password);
			statement = connection.createStatement();
			Scanner scan = new Scanner(System.in);
			System.out.println("Welcome to TEDU Crypto Stock Market Admin Panel");
			System.out.println();
			loop: while (true) {
				System.out.println("MENU:");
				System.out.println("1 - List of the users");
				System.out.println("2 - List of the coins ");
				System.out.println("3 - Create an order");
				System.out.println("4 - Uptade the field of user");
				System.out.println("5 - Delete Wallet");
				System.out.println("0 - exit");
				System.out.print("Enter a number>");
				String command = scan.nextLine();
				int choose = Integer.parseInt(command);
				if (command.equals("0")) {
					System.out.println("Bye.");
					break;
				}
				switch (choose) {
				case 1:
					resultSet_users1 = statement.executeQuery("SELECT * from users order by users.User_ID asc;");
					ResultSetMetaData rsmd_user1 = resultSet_users1.getMetaData();
					int columnsNumber_user1 = rsmd_user1.getColumnCount();
					while (resultSet_users1.next()) {
						for (int i = 1; i <= columnsNumber_user1; i++) {
							System.out.print(resultSet_users1.getString(i) + " ");

						}
						System.out.println("");
					}
					System.out.print("Enter a country you want to search--->");
					String country = scan.nextLine();
					System.out.println("------------------------");
					resultSet = statement
							.executeQuery("select users.Full_name,users.Country from users where users.Country = '"
									+ country + "' order by users.Full_name asc;");
					if (!(resultSet.next())) {
						System.out.println("TEDU Crypto Stock Market doos not have user from " + country);
					}
					do {
						System.out.println(resultSet.getString("Full_name") + " " + resultSet.getString("Country"));
					} while (resultSet.next());
					System.out.println("------------------------");
					System.out.print("Do you want to search new one? (Y/N) >");
					String cont = scan.nextLine();
					if (cont.toUpperCase().equals("N")) {
						break loop;
					}
					break;

				case 2:
					resultSet_users2 = statement.executeQuery("SELECT * from Coin order by Coin.Coin_ID asc;");
					ResultSetMetaData rsmd_user2 = resultSet_users2.getMetaData();
					int columnsNumber_user2 = rsmd_user2.getColumnCount();
					while (resultSet_users2.next()) {
						for (int i = 1; i <= columnsNumber_user2; i++) {
							System.out.print(resultSet_users2.getString(i) + " ");

						}
						System.out.println("");
					}
					System.out.print("Enter a coin name you want to search-->");
					String name = scan.nextLine();
					System.out.println("----------------------------------------");
					resultSet = statement.executeQuery(
							"select Coin.Coin_Name, Coin.number_of_users,Coin.Coin_ID,Coin.Protocol from Coin where Coin.Coin_Name = '"
									+ name + "';");
					if (!(resultSet.next())) {
						System.out.println("TEDU Crypto Stock Market doos not have " + name);
					}

					else {
						System.out.println(resultSet.getString("Coin_ID") + " " + resultSet.getString("Coin_Name") + " "
								+ resultSet.getString("number_of_users") + " " + resultSet.getString("Protocol"));
					}

					System.out.println("----------------------------------------");
					System.out.print("Do you want to search new one? (Y/N) >");
					String cont1 = scan.nextLine();
					if (cont1.toUpperCase().equals("N")) {
						break loop;
					}
					break;

				case 3:
					int user�d = 0;
					int op�d = 0;
					int temp_id = 0;
					double temp_prize = 0;
					System.out.println("------------------------");
					resultSet = statement.executeQuery(
							"SELECT Users.User_ID, Users.Full_name from users order by Users.User_ID asc;");
					while (resultSet.next()) {
						System.out.println(resultSet.getString("Full_name"));
					}
					System.out.println("------------------------");
					System.out.println("Enter the name of user you want to create order:");
					String names = scan.nextLine();
					resultSet = statement.executeQuery("SELECT Users.User_ID from Users where Users.Full_name = '"
							+ names + "' order by Users.User_ID asc;");

					while (resultSet.next()) {
						user�d = Integer.parseInt(resultSet.getString("User_ID"));
					}
					resultSet = statement.executeQuery(
							"SELECT max(Orders.Order_Code) from Orders where Orders.User_ID = '" + user�d + "';");

					while (resultSet.next()) {
						op�d = Integer.parseInt(resultSet.getString("Max"));
					}
					System.out.println("1-Enter the Operation Date(YYYY-MM-DD)");
					String date = scan.nextLine();
					System.out.println("2-Enter the Coin_Name");
					String coin_name = scan.nextLine();
					resultSet = statement
							.executeQuery("SELECT Coin.Coin_ID from Coin where Coin_Name = '" + coin_name + "';");
					while (resultSet.next()) {
						temp_id = Integer.parseInt(resultSet.getString("Coin_ID"));
					}
					resultSet = statement.executeQuery("SELECT Market.Price_of_coin from Market where Coin_ID = '"
							+ temp_id + "' and Market.Curr_Date='2021-05-16' ;");
					while (resultSet.next()) {
						temp_prize = Double.parseDouble(resultSet.getString("Price_of_coin"));
					}
					System.out.println("3-Enter the USDT_Value" + " The price of the coin right now " + temp_prize);
					int value = scan.nextInt();
					System.out.println("4-Enter the Amount_of_Coin");
					int amount = scan.nextInt();
					System.out.println("5-Enter the Op type");
					String type = scan.next();

					resultSet2 = statement.executeUpdate(
							"INSERT INTO Orders (Order_Code,Until_Date,Coin_Name,Coin_Amount,Op_Type,Limit_Price,user_id )\n"
									+ "values (" + (op�d + 1) + ",'" + date + "','" + coin_name + "', " + amount + ",'"
									+ type + "'," + value + "," + user�d + ");");

					System.out.println("Your order insert correctly.");
					System.out.println();

					System.out.print("");
					String cont3 = scan.nextLine();
					if (cont3.toUpperCase().equals("N")) {
						break loop;
					}
					break;

				case 4:
					System.out.println("------------------------");
					resultSet = statement.executeQuery(
							"SELECT Users.User_ID, Users.Full_name from users order by Users.User_ID asc;");
					while (resultSet.next()) {
						System.out.println(resultSet.getString("Full_name"));
					}
					System.out.println("------------------------");
					System.out.println("Enter the name of you want to uptade");
					String uptade_name = scan.nextLine();

					System.out.println("Enter the field of you want to uptade");
					String uptade_feild = scan.nextLine();
					System.out.println("You uptade it correctly.");
					resultSet2 = statement.executeUpdate("UPDATE users set Field='" + uptade_feild
							+ "' where users.full_name='" + uptade_name + "';");
					System.out.print("Continue? (Y/N) >");
					String cont4 = scan.nextLine();
					if (cont4.toUpperCase().equals("N")) {
						break loop;
					}
					break;

				case 5:
					System.out.println("------------------------");
					resultSet = statement.executeQuery(
							"SELECT Users.User_ID, Users.Full_name from users order by Users.User_ID asc;");
					while (resultSet.next()) {
						System.out.println(resultSet.getString("Full_name"));
					}
					System.out.println("------------------------");

					int user�d1 = 0;
					System.out.println("Enter the name you want to delete:");
					String names1 = scan.nextLine();
					resultSet = statement.executeQuery("SELECT Users.User_ID from Users where Users.Full_name = '"
							+ names1 + "' order by Users.User_ID asc;");

					while (resultSet.next()) {
						user�d1 = Integer.parseInt(resultSet.getString("User_ID"));
					}
					System.out.println(user�d1);
					resultSet2 = statement.executeUpdate("delete from wallet where User_ID=" + user�d1 + ";");
					System.out.println("You delete it correctly.");
					System.out.println();

					System.out.print("Continue? (Y/N) >");
					String cont5 = scan.nextLine();
					if (cont5.toUpperCase().equals("N")) {
						break loop;
					}
					break;
				}

			}
			connection.close();

		} catch (Exception e) {
			System.out.println("Error!");
			e.printStackTrace();
		} finally {
			close();
		}

	}

	int breaker = 0;

	private static void close() {
		try {
			if (resultSet != null) {
				resultSet.close();
			}

			if (statement != null) {
				statement.close();
			}
			if (connect != null) {
				connect.close();
			}
		} catch (Exception e) {
		}
	}

	public static boolean isAlph(char c) {

		boolean b = false;
		if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')) {
			b = true;
		} else {
			b = false;
		}
		return b;
	}

}
