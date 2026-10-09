<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Moffat Bay Login</title>
		<link rel="stylesheet" href="styles.css">
	</head>
	<body>
		<h1 style="text-align: center;">Login</h1>
		
		<p style="text-align: center;">All fields are required.</p>
		<form action="#" method="POST" class="form-container">
			<div class="form-column">
				<div class="form-group">
					<label for="email">Email</label>
					<input type="email" id="email" name="email" required>
				</div>
				<div class="form-group">
					<label for="password">Password</label>
					<input type="password" id="password" name="password" required>
				</div>
				<div class="form-group submit-group">
					<input type="submit" value="Login">
				</div>
			</div>
		</form>
		
		<div style="text-align: center;">
			<button onclick="window.location.href='index.jsp';">
				Return
			</button>
		</div>

	</body>
</html>