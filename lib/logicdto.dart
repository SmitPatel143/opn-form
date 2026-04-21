final formJson = [
  {
    "type": "text",
    "name": "Your name",
    "id": "743a7540-f8b5-4d3c-b45a-7948e51f02b8",
    "hidden": false,
    "help_position": "below_input",
    "width": "full",
    "align": "left",
    "show_char_limit": false,
    "src": false,
    "max_char_limit": 2000,
    "priority": "LOW",
    "sectionIndex": 0,
    "date_type": "date_only",
    "disabled_dates": "allow_all_dates",
    "logic": {
      "conditions": {
        "id": "242e2952-de9b-44f1-9a47-3e9f19026018",
        "operatorIdentifier": "and",
        "children": [
          {
            "id": "736342a3-cf4d-445e-a745-1ebcd5e02ba2",
            "identifier": "5aeedc61-fe31-42b7-aa32-3ff7d8f330a3",
            "value": {
              "operator": "equals",
              "property_meta": {
                "id": "5aeedc61-fe31-42b7-aa32-3ff7d8f330a3",
                "type": "select",
                "name": "Select",
              },
              "value": "s1",
            },
          },
          {
            "id": "39de7bfd-6886-4543-a7a5-32c68c777cf5",
            "identifier": "5aeedc61-fe31-42b7-aa32-3ff7d8f330a3",
            "value": {
              "operator": "is_not_empty",
              "property_meta": {
                "id": "5aeedc61-fe31-42b7-aa32-3ff7d8f330a3",
                "type": "select",
                "name": "Select",
              },
              "value": true,
            },
          },
          {
            "id": "6a3aa601-b071-4d4e-961b-e2adea433c95",
            "identifier": "5aeedc61-fe31-42b7-aa32-3ff7d8f330a3",
            "value": {
              "operator": "equals",
              "property_meta": {
                "id": "5aeedc61-fe31-42b7-aa32-3ff7d8f330a3",
                "type": "select",
                "name": "Select",
              },
              "value": "s2",
            },
          },
          {
            "id": "873985d6-f186-41b3-b769-ea9a55bb97e6",
            "identifier": "69b93838-898d-4c69-b82c-8a7dd397cb79",
            "value": {
              "operator": "equals",
              "property_meta": {
                "id": "69b93838-898d-4c69-b82c-8a7dd397cb79",
                "type": "date",
                "name": "Date",
              },
              "value": "2026-04-16",
            },
          },
          {
            "id": "57961f35-5945-485a-9e28-5dc4d3fcf278",
            "identifier": "69b93838-898d-4c69-b82c-8a7dd397cb79",
            "value": {
              "operator": "equals",
              "property_meta": {
                "id": "69b93838-898d-4c69-b82c-8a7dd397cb79",
                "type": "date",
                "name": "Date",
              },
              "value": "2026-04-17",
            },
          },
          {
            "id": "d2627691-6eac-4f63-a952-a0357874f330",
            "operatorIdentifier": "and",
            "children": [
              {
                "id": "ca99eb51-1e84-483d-91a6-e09aa4444154",
                "identifier": "b6f85d64-5bf9-497d-bf81-3ea2ac1762b3",
                "value": {
                  "operator": "content_length_less_than_or_equal_to",
                  "property_meta": {
                    "id": "b6f85d64-5bf9-497d-bf81-3ea2ac1762b3",
                    "type": "url",
                    "name": "Link",
                  },
                  "value": 5,
                },
              },
              {
                "id": "26746af3-0b13-4eff-8b9c-15fad8c70d0b",
                "identifier": "392746ca-4464-4d3a-ba56-f8205ed57f0a",
                "value": {
                  "operator": "is_empty",
                  "property_meta": {
                    "id": "392746ca-4464-4d3a-ba56-f8205ed57f0a",
                    "type": "files",
                    "name": "Files",
                  },
                  "value": true,
                },
              },
              {
                "id": "6b0498b6-7943-47cf-a869-ce5dbe76bc28",
                "identifier": "2e6cbdbb-327e-4851-8517-86af47a167a6",
                "value": {
                  "operator": "contains",
                  "property_meta": {
                    "id": "2e6cbdbb-327e-4851-8517-86af47a167a6",
                    "type": "multi_select",
                    "name": "Multi Select",
                  },
                  "value": "m2",
                },
              },
              {
                "id": "b53f9014-9107-4e18-a2f1-4e6c722b1ffc",
                "identifier": "fec024af-78f9-4ff8-adf5-1949ffff3510",
                "value": {
                  "operator": "less_than_or_equal_to",
                  "property_meta": {
                    "id": "fec024af-78f9-4ff8-adf5-1949ffff3510",
                    "type": "number",
                    "name": "Number",
                  },
                  "value": 87,
                },
              },
            ],
          },
          {
            "id": "513b3a0e-6984-4db7-9730-fc1085689c42",
            "operatorIdentifier": "and",
            "children": [
              {
                "id": "b4475c71-2ad3-4138-a910-3c3133de6c6f",
                "identifier": "69b93838-898d-4c69-b82c-8a7dd397cb79",
                "value": {
                  "operator": "equals",
                  "property_meta": {
                    "id": "69b93838-898d-4c69-b82c-8a7dd397cb79",
                    "type": "date",
                    "name": "Date",
                  },
                  "value": "2026-04-16",
                },
              },
              {
                "id": "30a55b71-fb0e-4e62-a3f3-c68fffd37ea5",
                "identifier": "bde7bbdd-c8fc-43de-bacb-eb1a76d7a562",
                "value": {
                  "operator": "does_not_contain",
                  "property_meta": {
                    "id": "bde7bbdd-c8fc-43de-bacb-eb1a76d7a562",
                    "type": "phone_number",
                    "name": "Phone Number",
                  },
                  "value": "12",
                },
              },
            ],
          },
        ],
      },
      "actions": ["disable-block"],
    },
  },
  {
    "type": "date",
    "name": "Date",
    "id": "69b93838-898d-4c69-b82c-8a7dd397cb79",
    "hidden": false,
    "help_position": "below_input",
    "width": "full",
    "align": "left",
    "priority": "LOW",
  },
  {
    "type": "url",
    "name": "Link",
    "id": "b6f85d64-5bf9-497d-bf81-3ea2ac1762b3",
    "hidden": false,
    "help_position": "below_input",
    "width": "full",
    "align": "left",
    "show_char_limit": false,
    "src": false,
    "max_char_limit": 2000,
    "priority": "LOW",
    "sectionIndex": 2,
    "date_type": "date_only",
    "disabled_dates": "allow_all_dates",
    "logic": {
      "conditions": {
        "id": "ca73177c-3b29-470f-8d37-ace137ce969f",
        "operatorIdentifier": "and",
        "children": [
          {
            "id": "40cbb69d-aeb8-401f-8c9b-909649de1056",
            "identifier": "743a7540-f8b5-4d3c-b45a-7948e51f02b8",
            "value": {
              "operator": "equals",
              "property_meta": {
                "id": "743a7540-f8b5-4d3c-b45a-7948e51f02b8",
                "type": "text",
                "name": "Your name",
              },
              "value": "test",
            },
          },
        ],
      },
      "actions": ["require-answer"],
    },
  },
  {
    "type": "phone_number",
    "name": "Phone Number",
    "id": "bde7bbdd-c8fc-43de-bacb-eb1a76d7a562",
    "hidden": false,
    "help_position": "below_input",
    "width": "full",
    "align": "left",
    "priority": "LOW",
    "maxLength": 10,
    "logic": {
      "conditions": {
        "id": "513b3a0e-6984-4db7-9730-fc1085689c42",
        "operatorIdentifier": "and",
        "children": [
          {
            "id": "b4475c71-2ad3-4138-a910-3c3133de6c6f",
            "identifier": "69b93838-898d-4c69-b82c-8a7dd397cb79",
            "value": {
              "operator": "equals",
              "property_meta": {
                "id": "69b93838-898d-4c69-b82c-8a7dd397cb79",
                "type": "date",
                "name": "Date",
              },
              "value": "2026-04-16",
            },
          },
          {
            "id": "30a55b71-fb0e-4e62-a3f3-c68fffd37ea5",
            "identifier": "bde7bbdd-c8fc-43de-bacb-eb1a76d7a562",
            "value": {
              "operator": "does_not_contain",
              "property_meta": {
                "id": "bde7bbdd-c8fc-43de-bacb-eb1a76d7a562",
                "type": "phone_number",
                "name": "Phone Number",
              },
              "value": "12",
            },
          },
        ],
      },
      "actions": ["disable-block"],
    },
  },
  {
    "type": "email",
    "name": "Email",
    "id": "f4d99ff6-81a2-448f-87bd-bb775cf9a755",
    "hidden": false,
    "help_position": "below_input",
    "width": "full",
    "align": "left",
    "show_char_limit": false,
    "src": false,
    "max_char_limit": 2000,
    "priority": "LOW",
  },
  {
    "type": "checkbox",
    "name": "Checkbox",
    "id": "d34b50d3-06d1-46e3-af72-4e1c2bbf1663",
    "hidden": false,
    "help_position": "below_input",
    "width": "full",
    "align": "left",
    "priority": "LOW",
    "sectionIndex": 5,
    "date_type": "date_only",
    "disabled_dates": "allow_all_dates",
    "logic": {
      "conditions": {
        "id": "75cd1732-565e-4804-a915-23604f2a72ca",
        "operatorIdentifier": "or",
        "children": [
          {
            "id": "877ebe28-525b-465d-b4ba-425984d73973",
            "identifier": "5aeedc61-fe31-42b7-aa32-3ff7d8f330a3",
            "value": {
              "operator": "equals",
              "property_meta": {
                "id": "5aeedc61-fe31-42b7-aa32-3ff7d8f330a3",
                "type": "select",
                "name": "Select",
              },
              "value": "s1",
            },
          },
          {
            "id": "2a261995-97cf-48e8-900d-0891e0224293",
            "identifier": "2e6cbdbb-327e-4851-8517-86af47a167a6",
            "value": {
              "operator": "contains",
              "property_meta": {
                "id": "2e6cbdbb-327e-4851-8517-86af47a167a6",
                "type": "multi_select",
                "name": "Multi Select",
              },
              "value": "m1",
            },
          },
          {
            "id": "d3e330f3-369d-4c04-853f-f9734bf2c2b7",
            "operatorIdentifier": "and",
            "children": [
              {
                "id": "27cba361-9a0e-41b7-98f6-c259370d3eff",
                "identifier": "392746ca-4464-4d3a-ba56-f8205ed57f0a",
                "value": {
                  "operator": "is_not_empty",
                  "property_meta": {
                    "id": "392746ca-4464-4d3a-ba56-f8205ed57f0a",
                    "type": "files",
                    "name": "Files",
                  },
                  "value": true,
                },
              },
              {
                "id": "b07bc56a-9826-4dd8-8e29-99a2649e3495",
                "identifier": "f4d99ff6-81a2-448f-87bd-bb775cf9a755",
                "value": {
                  "operator": "content_length_equals",
                  "property_meta": {
                    "id": "f4d99ff6-81a2-448f-87bd-bb775cf9a755",
                    "type": "email",
                    "name": "Email",
                  },
                  "value": 3,
                },
              },
            ],
          },
        ],
      },
      "actions": ["disable-block"],
    },
  },
  {
    "type": "select",
    "name": "Select",
    "id": "5aeedc61-fe31-42b7-aa32-3ff7d8f330a3",
    "hidden": false,
    "select": {
      "options": [
        {
          "name": "s1",
          "id": "s1",
          "is_correct_answer": false,
          "is_flag": false,
        },
        {
          "name": "s2",
          "id": "s2",
          "is_correct_answer": false,
          "is_flag": false,
        },
      ],
    },
    "help_position": "below_input",
    "width": "full",
    "align": "left",
    "selectedOptionType": "custom",
    "priority": "LOW",
  },
  {
    "type": "multi_select",
    "name": "Multi Select",
    "id": "2e6cbdbb-327e-4851-8517-86af47a167a6",
    "hidden": false,
    "multi_select": {
      "options": [
        {
          "name": "m1",
          "id": "m1",
          "is_correct_answer": false,
          "is_flag": false,
        },
        {
          "name": "m2",
          "id": "m2",
          "is_correct_answer": false,
          "is_flag": false,
        },
      ],
    },
    "help_position": "below_input",
    "width": "full",
    "align": "left",
    "selectedOptionType": "custom",
    "priority": "LOW",
  },
  {
    "type": "number",
    "name": "Number",
    "id": "fec024af-78f9-4ff8-adf5-1949ffff3510",
    "hidden": false,
    "help_position": "below_input",
    "width": "full",
    "align": "left",
    "show_char_limit": false,
    "src": false,
    "max_char_limit": 2000,
    "priority": "LOW",
  },
  {
    "type": "files",
    "name": "Files",
    "id": "392746ca-4464-4d3a-ba56-f8205ed57f0a",
    "hidden": false,
    "help_position": "below_input",
    "width": "full",
    "align": "left",
    "priority": "LOW",
  },
];
