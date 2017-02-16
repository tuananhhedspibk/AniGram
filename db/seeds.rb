User.create!(name: 		"admin",
			 email: 	"admin@mail.com",
			 password: 					"foobar",
			 password_confirmation: 	"foobar",
			 gender: 	"Male",
			 admin: 	true)

99.times do |n|
	name  = Faker::Name.name
	email = "example-#{n+1}@railstutorial.org"
	password = "password"
	User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               gender: 	"Male")
end