// This is pretty terrible JS code.
// The focus of the training is ruby so please don't hit me too hard.
$().ready(() => {
  const $typeahead        = $('#typeahead')
  const $typeaheadId      = $('#typeahead-id')
  const $typeaheadResults = $('#typeahead-results')

  const setup = () => {
    $typeahead.keyup(typeahead)
  }

  const typeahead = e => {
    if (e.target.value.length < 3) { return }
    $.get(`api/cities?name=${e.target.value}`, displayList)
  }

  const displayList = response => {
    const cities = response.map(city => (
      `<li class="list-group-item list-group-item-action typeahead-result" data-id="${city.id}" data-name="${city.name}">${city.name}</li>`
    ))
    $typeaheadResults.html(cities)
    $('.typeahead-result').click(selectResult)
  }

  const selectResult = e => {
    const $item = $(e.target)
    const id    = $item.data('id')
    const name  = $item.data('name')

    $typeahead.val(name)
    $typeaheadId.val(id)
    $typeaheadResults.html('')
  }

  setup()
})
