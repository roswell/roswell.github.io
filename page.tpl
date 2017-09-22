<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1">
		<title>Roswell - Common Lisp environment setup Utility.</title>
		<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
		<link href="https://fonts.googleapis.com/css?family=Orbitron:700" rel="stylesheet">
		<style>
html, body {
	height: 100%;
}
main {
	margin-top: 100px;
}
footer {
	background:#f6f6f6;
	height: 100px;
	padding: 10px;
}
#title {
	margin-bottom: 30px;
}
.navbar-brand {
	font-family: 'Orbitron', sans-serif;
}
.dropdown-item:hover, .dropdown-item:focus{
	background-color: transparent;
}
		</style>
	</head>
	<body>
		<header>
			<nav class="navbar fixed-top navbar-expanded-xl navbar-dark bg-success">
				<a class="navbar-brand" href=".">
					roswell
				</a>
				<div class="navbar-nav mr-auto">
					<a class="nav-item nav-link text-light github" href="https://github.com/roswell/roswell">
						Contribute in
						<i class="fa fa-github" aria-hidden="true"></i>
					</a>
				</div>
				<button class="navbar-toggler d-xs-block d-sm-block d-md-none" type="button" data-toggle="collapse" data-target="#menu" aria-controls="menu" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="menu">
					<ul class="navbar-nav">
						<% @loop index %>
							<li class="nav-item dropdown">
								<a id="<% @var name %>" class="nav-link dropdown-toggle text-light" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expand="false">
									<% @var name %>
								</a>
								<div class="dropdown-menu bg-success" aria-labelledby="<% @var name %>">
									<% @loop pages %>
										<a class="dropdown-item text-light" href="<% @var link %>">
											<% @var name %>
										</a>
									<% @endloop %>
								</div>
							</li>
						<% @endloop %>
					</ul>
				</div>
			</nav>
		</header>
		<main>
			<div class="container">
				<div class="row">
					<aside class="col-md-4 col-lg-3 d-none d-md-block d-lg-block d-xl-block">
						<ul class="">
							<% @loop index %>
								<li class="">
									<% @var name %>
									<ul class="">
										<% @loop pages %>
										<li>
											<a class="" href="<% @var link %>">
												<% @var name %>
											</a>
										</li>
										<% @endloop %>
									</ul>
								</li>
							<% @endloop %>
						</ul>
					</aside>
					<article class="col-md-8 col-lg-9">
						<h1 id="title"><% @var title %></h1>
						<% @var content %>
					</article>
				</div>
			</div>
		</main>
		<footer>
			<div class="container text-center">
				<p>
					<a href="https://github.com/roswell/roswell">Roswell</a> /
					<a href="https://github.com/roswell/roswell/blob/master/COPYING">Distributed under MIT License</a> /
					<a href="https://github.com/roswell/roswell/blob/master/README.md#author">Author</a>
				</p>
				<p>
				Found an issue with the docs? Report it <a href="https://github.com/roswell/roswell/issues">here</a>.
				</p>
			</div>
		</footer>
		<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
	</body>
</html>
