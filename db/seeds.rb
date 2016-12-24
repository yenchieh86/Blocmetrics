Application.destroy_all
Event.destroy_all
User.destroy_all

u = User.new(email: 'test@bloc.com', password: 'password')
u.skip_confirmation!
u.save

u = User.new(email: 'yenchieh86@hotmail.com', password: 'password')
u.skip_confirmation!
u.save

5.times do 
    title_parameter = Faker::Company.name
    Application.create(
        title: title_parameter,
        user_id: u,
        slug: title_parameter,
        url: Faker::Internet.url,
        created_at: Time.now,
        updated_at: Time.now
    )
end


a = Application.first

5.times do 
    Event.create(
        name: Faker::Company.name,
        application: a,
        created_at: Time.now,
        updated_at: Time.now
    )
end

5.times do 
    Event.create(
        name: 'yenyenyen',
        application: a,
        created_at: Time.now,
        updated_at: Time.now
    )
end

user = User.count
apps = Application.count
events = Event.count

puts "#{user} user, #{apps} applications and #{events} events have been created"