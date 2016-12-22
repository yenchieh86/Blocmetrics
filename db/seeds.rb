Application.destroy_all
Event.destroy_all

u = User.first.id

5.times do 
    title_parameter = Faker::Company.name
    Application.create(
        title: title_parameter,
        user_id: u,
        slug: title_parameter,
        url: "/users/#{u}/registered_applications/#{title_parameter}",
        created_at: Time.now,
        updated_at: Time.now
    )
end


a = Application.first

5.times do 
    Event.create(
        name: Faker::Company.name,
        application_id: a.id,
        created_at: Time.now,
        updated_at: Time.now
    )
end

5.times do 
    Event.create(
        name: 'yenyenyen',
        application_id: a.id,
        created_at: Time.now,
        updated_at: Time.now
    )
end