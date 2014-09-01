---
---

baseURL = "https://api.travis-ci.org/repos"

#
# Fills a string containing special templating syntax with the data provided.
#
# Ex:
#    tmpl = "${name} got a ${grade} in ${course}.";
#    data = { name: "John", grade: "B", course: "Plant Pathology" };
#    tmpl.template(data); // outputs "John got a B in Plant Pathology."
#
String.prototype.fill = (data) ->
    regex = null
    completed = @toString()
    for el, value of data
      break if completed.indexOf("$") < 0
      regex = new RegExp("\\${#{el}}", 'g')
      completed = completed.replace(regex, value)
    completed.toString()

makeXHRRequest = (url, callback) ->
  myRequest = new XMLHttpRequest()
  myRequest.onreadystatechange = extractData(callback)
  myRequest.open("get", url, true)
  myRequest.setRequestHeader("Accept", "application/vnd.travis-ci.2+json")
  myRequest.send()

extractData = (callback) ->
  return ->
    if @readyState == 4
      callback(JSON.parse(this.responseText))

getRepos = (callback) ->
  makeXHRRequest("/repos.json", callback)

fetchAndDisplayStatuses = (repos) ->
  console.log("Processing repos:", repos)
  for repo in repos
    makeXHRRequest("#{baseURL}/#{repo.nwo}", formatStatus)

formatStatus = (data) ->
  console.log(data.repo)
  addToRepos "${slug}".fill(data.repo)

addToRepos = (el) ->
  document.getElementsByClassName("repos")[0].innerText += el

document.onreadystatechange = ->
  if @readyState == "complete"
    getRepos(fetchAndDisplayStatuses)

