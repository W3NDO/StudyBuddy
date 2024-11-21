# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

topics = {
  "Ruby" => ["Programming", "Scripting", "Backend"],
  "JavaScript" => ["Frontend", "Web Development", "React"],
  "Python" => ["Data Science", "Machine Learning", "Backend"],
  "Docker" => ["DevOps", "Containers", "Deployment"],
  "Rails" => ["MVC", "Ruby", "Web Development"]
}

questions = {
    "Ruby" => [
      "How would you ignite programming in Ruby?", 
      "How would you innovate scripting in Ruby?", 
      "How would you sight backend in Ruby?"
    ],
    "JavaScript" => [
      "How would you invent frontend in JavaScript?", 
      "How would you impend web development in JavaScript?", 
      "How would you shock react in JavaScript?"
    ],
    "Python" => [
      "How would you converge data science in Python?", 
      "How would you thrust machine learning in Python?", 
      "How would you realize backend in Python?"
    ],
    "Docker" =>[
      "How would you expect devops in Docker?", 
      "How would you begin containers in Docker?", 
      "How would you clothe deployment in Docker?"
    ],
    "Rails" =>[
      "How would you mistake mvc in Rails?", 
      "How would you rob ruby in Rails?", 
      "How would you create web development in Rails?"
    ]
  }
def create_default_user
  User.create(email: "test@email.com", password: "foobar123", password_confirmation: "foobar123", handle: "foobar", username: "John Doe")
  User.create(email: "edi@studybuddy.com", password: "foobar123", password_confirmation: "foobar123", handle: "SB1", username: "Study Buddy 1")
end

def create_user
  pass = Faker::Internet.password
  User.create(email: Faker::Internet.email, password: pass, password_confirmation: pass, handle: Faker::Name.first_name, username: Faker::Name.name )
end

def create_study_session
  StudySession.create(
    session_name: "Test session", 
    session_description: "A test of the session model",
    user_id: 1
  )
end

def create_topic(topic_name, tags)
  Topic.create(
    name: topic_name,
    tags: tags.join(","),
    # session: StudySession.all.sample
  )
end

def create_messages(topic_name, question)
  SessionMessage.create(
    user_id: 1,
    content: question,
    time: Time.now,
    study_session_id: 1
  )
end

## Build everything
create_default_user
9.times { create_user }
5.times { create_study_session }
topics.each do |topic, tags|
  create_topic(topic, tags)
end
questions.each do |topic, questions|
  create_messages(topic, questions.sample)
end