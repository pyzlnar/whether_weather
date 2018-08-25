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
    const cities = response.data.map(getCityHtml)
    $typeaheadResults.html(cities)
    $('.typeahead-result').click(selectResult)
  }

  const getCityHtml = city => {
    const { id, attributes: { name } } = city
    return `<li class="list-group-item list-group-item-action typeahead-result" data-id="${id}" data-name="${name}">${name}</li>`
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
