terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 3.6.0"
    }
  }
}

# Configure the GitLab Provider
provider "gitlab" {
    token = var.gitlab_token
    base_url = "http://${var.gitlab_server}/api/v4/"
}

#Create groups
resource "gitlab_group" "groups" {
    for_each = toset( ["red", "green", "blue"] )
    name = each.key
    path = each.key
}

#
#Create 3 Projects for each group
#
resource "gitlab_project" "projects_red" {
    for_each = toset( ["Project1", "Project2", "Project3"] )
    name = each.key
    namespace_id = gitlab_group.groups["red"].id
}

resource "gitlab_project" "projects_green" {
    for_each = toset( ["Project1", "Project2", "Project3"] )
    name = each.key
    namespace_id = gitlab_group.groups["green"].id
}

resource "gitlab_project" "projects_blue" {
    for_each = toset( ["Project1", "Project2", "Project3"] )
    name = each.key
    namespace_id = gitlab_group.groups["blue"].id
}

#Create users. Each use will be sent a mail to reset his password
resource "gitlab_user" "users" {
  for_each = toset (["user1", "user2", "user3", "user4", "user5","user6","user7","user8","user9","user10"] )
  name             = each.key
  username         = each.key
  email            = "${each.key}@user.create"
  is_admin         = false
  can_create_group = false
  is_external      = true
  reset_password   = true
  password = ""
}

#Map users to their groups
#User 1: red
#User 2: red
#User 3: red, green
#User 4: green, blue
#User 5: green, blue
#User 6: red, green, blue
#User 7: green
#User 8: green
#User 9: red, blue
#User 10: blue

resource "gitlab_group_membership" "user1_red" {
  group_id     = gitlab_group.groups["red"].id
  user_id      = gitlab_user.users["user1"].id
  access_level = "developer"
}

resource "gitlab_group_membership" "user2_red" {
  group_id     = gitlab_group.groups["red"].id
  user_id      = gitlab_user.users["user2"].id
  access_level = "developer"
}

resource "gitlab_group_membership" "user3_red" {
  group_id     = gitlab_group.groups["red"].id
  user_id      = gitlab_user.users["user3"].id
  access_level = "developer"
}
resource "gitlab_group_membership" "user3_green" {
  group_id     = gitlab_group.groups["green"].id
  user_id      = gitlab_user.users["user3"].id
  access_level = "developer"
}
resource "gitlab_group_membership" "user4_green" {
  group_id     = gitlab_group.groups["green"].id
  user_id      = gitlab_user.users["user4"].id
  access_level = "developer"
}
resource "gitlab_group_membership" "user4_blue" {
  group_id     = gitlab_group.groups["blue"].id
  user_id      = gitlab_user.users["user4"].id
  access_level = "developer"
}
resource "gitlab_group_membership" "user5_green" {
  group_id     = gitlab_group.groups["green"].id
  user_id      = gitlab_user.users["user5"].id
  access_level = "developer"
}
resource "gitlab_group_membership" "user5_blue" {
  group_id     = gitlab_group.groups["blue"].id
  user_id      = gitlab_user.users["user5"].id
  access_level = "developer"
}
resource "gitlab_group_membership" "user6_red" {
  group_id     = gitlab_group.groups["red"].id
  user_id      = gitlab_user.users["user6"].id
  access_level = "developer"
}
resource "gitlab_group_membership" "user6_green" {
  group_id     = gitlab_group.groups["green"].id
  user_id      = gitlab_user.users["user6"].id
  access_level = "developer"
}
resource "gitlab_group_membership" "user6_blue" {
  group_id     = gitlab_group.groups["blue"].id
  user_id      = gitlab_user.users["user6"].id
  access_level = "developer"
}
resource "gitlab_group_membership" "user7_green" {
  group_id     = gitlab_group.groups["green"].id
  user_id      = gitlab_user.users["user7"].id
  access_level = "developer"
}
resource "gitlab_group_membership" "user8_green" {
  group_id     = gitlab_group.groups["green"].id
  user_id      = gitlab_user.users["user8"].id
  access_level = "developer"
}
resource "gitlab_group_membership" "user9_red" {
  group_id     = gitlab_group.groups["red"].id
  user_id      = gitlab_user.users["user9"].id
  access_level = "developer"
}
resource "gitlab_group_membership" "user9_blue" {
  group_id     = gitlab_group.groups["blue"].id
  user_id      = gitlab_user.users["user9"].id
  access_level = "developer"
}
resource "gitlab_group_membership" "user10_blue" {
  group_id     = gitlab_group.groups["blue"].id
  user_id      = gitlab_user.users["user10"].id
  access_level = "developer"
}