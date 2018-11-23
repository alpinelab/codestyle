# AlpineLab process guide

## Summary

1. [Kanban / Project management](#1-kanban--project-management)

2. [Branching Model](#2-branching-model)
)
3. [Review process](#3-review-process)

4. [Continuous Integration](#4-continuous-integration)

5. [Merge](#5-merge)

6. [Continuous Development](#6-continuous-development)

7. [Hosting](#7-hosting)

8. [Local setup](#8-local-setup)

## 1. Kanban / Project Management

We use the method Agile for every project, and we love it !
Consequently, every project is organised thanks to his dedicated Kanban Board.
Here is a great article about Kanban board, our way to manage Task Board: [Kanban board](https://www.agilealliance.org/glossary/kanban-board/)

On Kanban board, each feature is related to a card, which is basically moved from "ToDo" to "Done" status ... through a columns itinerary that we choose, according to our client.

According to the client, we move the cards with their agreement, or he can move them themself (which can lead to add columns on purpose).

### Column list

- **:bulb: Ideas**
  - only ideas here, but not ready to be started

- (Projets ?)

- **To estimate**
  - here, the proposals considered worthy of interest, awaiting for an estimation (time or complexity)

- **:checkered_flag: Ready to start**
  - if card is here, development can start

- **:wrench:  In progress**
  - when a developer is working on this card

- (On hold ?)

- **:mag_right: Review requested**
  -The developer,  in his opinion, has finished his work and asks a review (we always ask review!)

- (In review ?)

- **Review by client requested**
  - When reviewer validates every point of the Pull Request, client can test and validate the feature (thanks to review-app)

- **:x: Rejected by client**
  - Card is here if client asks some modifications. After discussion with client, card can come back to "Review by client requested"

- **:rocket:  Good to merge**
  - Both reviewer and client did validate the feature : Ready to merge.

- **:ship: Shipped**
  - Card is finished, some code has been shipped to production

- **:heavy_check_mark: Completed**
  - Card is finished, some issue has been fixed (it can be an answer to a question)

Of course, purpose is to pull card from left to the right... Not like these [two developpers](http://www.commitstrip.com/en/2018/03/29/in-progress/) !

## 2. Branching Model

All of our project are hosted on Github, and we are very careful with branching management, according to git's good practices.

Unsurprisly, `master` is the base branch. And, once project installation is finished, we never push code on `master`.

**Branch content**
One branch is independent, it fixes a isolated feature. We'll highly prefer to split a biggest pull-request on several but isolated pull requests.

If we revert a branch, it should not break the project !

A branch includes commits which are although isolated.
We don't use commit to keep history of our push!

**Commit content**
Each commit is independent, can be reverted without breaking the code. If they are too many commits on a branch, it could means that doing several branchs would have been the better way to do it.

For exemple, it would be a bad solution to have one commit with some feature's development, one further commit with related test. Each testable code added to a commit has to be commited with the related test code !

Thus, we can revert every commit without breaking the code...

Of course, it would be tough to build perfect commit at the first try... That's why we use a lot commands like:
- `git commit --amend`
- `git rebase [branch]`
- `git rebase -i HEAD~[nb]`

What each developper is doing during our development phase is our buisness... But only clean code has to go to Github !
Especially, only clean code, with clean git history, has to be reviewed on Github.

You can imagine this situation:

>You introduce something on 1st commit, you keep cooding... 2 hours later, your modify what you had introduced on first commit... and you include these modifications to a third commit.
 When reviewer start to review you project, he could reveiw commit per commit. He disagrees with you first commit, and take time to write feedbacks about your work... And then he switches to the 3rd commit: All this time he spent was useless ! Because of dirty commit history !!!

**Commit messages**
Commits have to be as explicit as possible. So we do our best to documents them properly.
Indeed, commit messages are highly recommended, and we follow these rules about syntax:

```ruby
"Title (50 characters maximum)"
empty line
"description line (72 characters maximumn)"
"if description needs more the 72 characters, we prefer to use several
lines to write this description"
```

## 3. Review process

It's a main point for us to produce some quality code. And every single line of code we merge to master has been reviewed by (at least) one other developper.
Every project is defined with protected branch.

We request a revision only when the pull request is reviewable!
Up to this point, a branch can be pushed on Github, and the associated pull request can exist
(this is also a good way for the developer to validate how good his code is / revisable!).
To make this step easier, we use Github tags, like "Work in Progress"

Pull request is ready to be reviewed when:
- Commit messages are clear enough (you should not have to give more explainations than message's content to the reviewer)
- Labels are set (migration / bundle required...)
- Author is identified as assignee

**That's when you can request a review :mag_right:**

By requesting an other developper thanks to Github tool : "Request a review"

Reviewer can leave comments to specific parts of code, ask more informations, request specific changes
Dicussion with the author and the reviewer, and other devloppers of the team can give their advice on specific points...

PS : According to our rules about commit partition (cf part 2. Branching model), if the reviewer asks some modifications, the author as to include them *on the related commit* !
Knowledge about `git commit --amend`, `git rebase` and `git squash` is here very useful :wink:

After what, the reviewer may "Approve" the pull request.
:tada:
Branch is ready to be merged on `master`

## 4. Continuous Integration

Our projects include some Code Integration tools, for steps :
- Merge branch on `master`
- Create pull request with new branch
- Update content of branchs related to pull-request

Solution we have chosen is Codeship : https://codeship.com/ (it could have been Travis CI, Heroku CI ...)
CodeShip runs several tasks each time that one of this action is requested:

```shell
sed -i "s|5432|5434|" "config/database.yml"  # => import database configuration
rvm use . --install # => import correct ruby version
bundle config build.nokogiri --use-system-libraries # => import config settings
bundle install # => import Gemfile configuration
bundle exec rake db:schema:load # => import schema configuration
bundle exec rspec --order TYPE[rand] # => run tests (if one test fails, build is rejected)
```

## 5. Merge

When pull request is reviewed and accepted, it's time to merge it. Here is one of our main point of attention!

By default, Github offers the choice between three possibilities to merge a pull-request on `master`.

**Create a merge commit**
*All commits from this branch will be added to the base branch with a merge commit*

**Squash and merge**
*The #{nb} commits from this branch will be combined into one commit in the base branch.*

**Rebase and merge**
*The #{nb} commits from this branch will be rebased and added to the base branch*

Commit's history for branch to merge has to be clean, every commit brings an independent but necessary update (cf 2. Branching Model). Consequently, we don't want to drop this history by merging on master. **Rebase and merge** should be our only valuable option.

But there is still a possible issue with this merge option: if branch is not up to date with `master`, and tests failed after merging... Problematic branch has already been merged !

That's why we use a 4th merge option : **Bors** (here on [Github](https://github.com/bors-ng/bors-ng) )

>To understand why this is insufficient to get an evergreen master, imagine this:
>
>Pull Request #1: Rename bifurcate() to bifurcateCrab()
>
>Change the name of this function, as well as every call site that currently exists in master. I've thought of making it a method on Crab instead of on Sword, but then it would be bifurcateWithSword(), which hardly seems like an improvement.
>
>  Pull Request #2: bifurcate() after landing, in addition to before
>
>  Adds another call to bifurcate(), to make sure it gets done even if we skip the pre-landing procedure.
>
>When both of these pull requests are sitting open in the backlog, they will both be tested against master. Assuming they both pass, GitHub will happily present the Big Green Merge Button. Once they both get merged master will go red (Method bifurcate() not found).

Rather than clicking on this "Big Green Merge Button, we just wrote as commnt to the pull-request:
```shell
  bors r+
```
And here is what's happends thanks to bors:

1. "Update the pull requests," merging them onto master without changing master itself
2. Wait for the test suite to finish
3. Merge the pull request when it's done, which is a trivial operation that can't break the test suite thanks to step 1

No more issue by merging !

## 6. Continuous Development

Our solution to manage continuous development is Heroku Pipeline.

Pipeline stages can include more than one app. In our case, pipelines are composed of three columns:

**Review-apps:**

For each pull-request, for each branch, we have the related promoted review-app, hosted on Heroku.
Each review-app is unique, and is named as
  ```ruby
  "#{projet_name}_staging_pr_#{id}"
  ```

*On our Kanban board, each card is associated with related pull request on Github, and related review-app on Heroku.*

Thus, it helps us to improve feature's validation (it's already online), and we can ask client validation! Indeed, Github is not the best solution to ask validation to every client :wink:  )
Database may be generated from spec file, or from a dump of production database. In this case, behavior is very closed from "real-life", it's easier for client to validate. But related issue is production database size ...
  >The problem is that review apps can only use Heroku Postgres free plan, which has a maximum allowed capacity of 10,000 lines. If you exceed it, Heroku disrupts it after 24 hours by setting it read-only...:sob:

Hopefully, we are developers ! So, we've developped our open-source solution : [Heroku Reviews Apps Awakener 📢 😴](https://github.com/alpinelab/heroku-review-apps-awakener)!



**Staging:**
The staging app is promoted from the branch `master`.
It's updated each time a branch is merged on master (automatic deploys).
This app is named as `"#{projet_name}_staging"`.
Because this review-app it's only created one time, we have to refresh database frequently (if it's imported from production),
with a command like:
```shell
"heroku pg:copy DATABASE STAGING_DATABASE --confirm #{project-name}-production -a #{project-name}-production"
```
And for the same reason, we have to run pending migrations on this app, with a command like :
```ruby
"heroku run -a #{project-name}-staging (rails_version < 5 ? rake || rails) db:migrate"
```

Main purpose of the staging app is to build an deamon (/draft / crashtest) of the production app:
- If staging-app is running without problemn, it can be promoted easily to production
- If staging-app raises error during log ... production is safe !


**Production:**
As we can guess, only one app here : production !
Everything has been done to validate modifications on previous steps, so production should not be impacted by unfortunate changes.
Still one point to be careful about : run pending migrations !

If `db:migrate`, or a specific `rake` task is too long, we can set the production on maintenance with commands as :
```shell
heroku maintenance:on --app #{name}
--- migrations / rake task ---
heroku maintenance:off --app #{name}
```

## 7. Hosting
(monitoring tools ...)

To be honest, I don't know how to fill this part... I never had to host a website for AlpineLab !


## 8. Local setup

On our team, we don't have the same opnion about how to install a project:

- some of us prefer to manage with :computer: local setup
- some of us prefer to manage with :whale: Docker setup

And obviously, a lot of developers have different opinions about Docker... [Especially these four there](http://www.commitstrip.com/en/2016/06/24/how-to-host-a-coder-dinner-party/)

And thanks to the existence of this choice, we do maintain documentation and ability, for every project, to choose between these two possibilities.

Thus, on `README.md`, we'll always maintain description about how to install locally or threw docker-compose.

Indeed, all of our project include `docker-compose.yml` and related script on `Dockerfile`
And above all, we do maintain repo [Alpinelab/docker-ruby-dev](https://github.com/alpinelab/docker-ruby-dev):
> Easy, generic, consistent and non-intrusive Docker setup for all your Ruby projects.
