require "application_system_test_case"

class ChecklistItemsTest < ApplicationSystemTestCase
  setup do
    @checklist_item = checklist_items(:one)
  end

  test "visiting the index" do
    visit checklist_items_url
    assert_selector "h1", text: "Checklist Items"
  end

  test "creating a Checklist item" do
    visit checklist_items_url
    click_on "New Checklist Item"

    fill_in "Checklist", with: @checklist_item.checklist_id
    fill_in "Status", with: @checklist_item.status
    fill_in "Title", with: @checklist_item.title
    click_on "Create Checklist item"

    assert_text "Checklist item was successfully created"
    click_on "Back"
  end

  test "updating a Checklist item" do
    visit checklist_items_url
    click_on "Edit", match: :first

    fill_in "Checklist", with: @checklist_item.checklist_id
    fill_in "Status", with: @checklist_item.status
    fill_in "Title", with: @checklist_item.title
    click_on "Update Checklist item"

    assert_text "Checklist item was successfully updated"
    click_on "Back"
  end

  test "destroying a Checklist item" do
    visit checklist_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Checklist item was successfully destroyed"
  end
end
