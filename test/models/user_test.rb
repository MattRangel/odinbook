require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user1 = User.create(email: "user1@example.com", password: "123456")
    @user2 = User.create(email: "user2@example.com", password: "abcdef")
  end

  teardown do
    Rails.cache.clear
  end

  test "user can follow other user" do
    assert(@user1.follow(@user2).valid?)
  end

  test "user can't follow other user while already following" do
    @user1.follow(@user2)
    assert_not(@user1.follow(@user2).valid?)
  end

  test "user1 follows user2 --> relationship in user1's following list" do
    relationship = @user1.follow(@user2)
    assert_includes(@user1.following_relationships, relationship)
  end

  test "user1 follows user2 --> relationship in user2's followed by list" do
    relationship = @user1.follow(@user2)
    assert_includes(@user2.followed_by_relationships, relationship)
  end

  test "Users can like post" do
    post = @user1.posts.create(body: "Hello World")
    assert(@user2.like(post).valid?)
  end

  test "User can't like post twice" do
    post = @user1.posts.create(body: "Hello World")
    @user2.like(post)
    assert_not(@user2.like(post).valid?)
  end

  test "User can comment on a post" do
    post = @user1.posts.create(body: "Hello World")
    assert(@user2.comment(post, "Cool!").valid?)
  end
end
