User.create(
    email: Rails.application.credentials.creator_email,
    password: Rails.application.credentials.creator_password,
    password_confirmation: Rails.application.credentials.creator_password,
    first_name: "Maia",
    last_name: "Cruz",
    username: "maiapancake",
    role: "admin",
    plan: "benefactor",
    image: "profile.jpg",
    confirmed_at: DateTime.now
)