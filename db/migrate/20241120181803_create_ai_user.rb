class CreateAiUser < ActiveRecord::Migration[7.0]
  def up
    User.create!(email: "edi@mystudybuddy.com", password: "foobar123", password_confirmation: "foobar123", handle: "SB1", username: "Study Buddy 1")
  end

  def down
    User.find_by(handle: "SB1")&.destroy
  end
end
