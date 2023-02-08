import { ArrowLeftOutlined, MailOutlined } from "@ant-design/icons";
import { Button, Checkbox, Form, Input, Radio, Space, Typography } from "antd";
import cx from "classnames";
import { useDispatch } from "react-redux";
import { registrationFlowActions } from "store/registrationFlow/slice";
import { userLogin } from "store/registrationFlow/thunks";
import { KcContext_LoginUpdateProfile } from "..";

import styles from "./index.module.scss";

enum FORM_FIELDS {
  FIRST_NAME = "first_name",
  LAST_NAME = "last_name",
  EXTERNAL_ID = "external_id",
  USER_ID = "user_id",
  FULL_NAME = "full_name",
  EXTERNAL_EMAIL = "external_email",
  ROLES = "roles",
  OTHER_ROLE = "other_role",
  AFFILIATION = "affiliation",
  NO_AFFILIATION = "no_affiliation",
  DATA_USAGE = "data_use",
  OTHER_DATA_USAGE = "other_data_use",
  RESEARCH_AREA = "reasearch_area",
  COMMERCIAL_USE_REASON = "commercial_use_reason",
}

enum EXTERNAL_ID_OPTIONS {
  ERA = "era",
  NO = "no",
}

const OTHER_KEY = "other";

const { Title, Text } = Typography;

const roleOptions = [
  "Researcher At an academic or not-for-profit Institution",
  "Representative from a for-profit or Commercial Entity",
  "Tool or Algorithm Developer",
  "Clinician",
  "Community Member",
  "Federal Employee",
];

const usageOptions = [
  {
    key: "learn",
    value:
      "Learning more about Down syndrome and its health outcomes, management, and/or treatment",
  },
  {
    key: "help",
    value: "Helping me design a new research study",
  },
  {
    key: "analyse",
    value: "Identifying datasets that I want to analyze",
  },
  {
    key: "commercial",
    value: "Commercial purposes",
  },
];

const hasOtherUsage = (userUsages: string[]) =>
  userUsages.find(
    (usage) =>
      !usageOptions.find((defaultUsage) => defaultUsage.value === usage)
  );

const hasOtherRole = (userRoles: string[]) =>
  userRoles.find(
    (role) => !roleOptions.find((defaultRole) => defaultRole === role)
  );

const SurveyStep = ({
  kcContext,
}: {
  kcContext: KcContext_LoginUpdateProfile;
}) => {
  const dispatch = useDispatch();
  const [form] = Form.useForm();

  const validateMessages = {
    required: "This field is required",
    types: {
      email: "Enter a valid email",
    },
    string: {
      min: `\${min} characters minimum`,
    },
  };

  const removeOtherKey = (list: string[], otherValue: string) => {
    const listWithoutOtherKey = list.filter((value) => value !== OTHER_KEY);
    if (otherValue) {
      listWithoutOtherKey.push(otherValue);
    }
    return listWithoutOtherKey;
  };
  return (
    <Form
      form={form}
      className={styles.registrationForm}
      fields={[
        {
          name: [FORM_FIELDS.FIRST_NAME],
          value: kcContext.userProfile.first_name,
        },
        {
          name: [FORM_FIELDS.LAST_NAME],
          value: kcContext.userProfile.last_name,
        },
        {
          name: [FORM_FIELDS.EXTERNAL_ID],
          value: kcContext.userProfile.era_commons_id
            ? EXTERNAL_ID_OPTIONS.ERA
            : kcContext.userProfile.external_individual_email &&
              kcContext.userProfile.external_individual_fullname
            ? EXTERNAL_ID_OPTIONS.NO
            : undefined,
        },
        {
          name: [FORM_FIELDS.EXTERNAL_EMAIL],
          value: kcContext.userProfile.external_individual_email,
        },
        {
          name: [FORM_FIELDS.FULL_NAME],
          value: kcContext.userProfile.external_individual_fullname,
        },
        {
          name: [FORM_FIELDS.USER_ID],
          value: kcContext.userProfile.era_commons_id,
        },
        {
          name: [FORM_FIELDS.ROLES],
          value: kcContext.userProfile.roles,
        },
        {
          name: [FORM_FIELDS.COMMERCIAL_USE_REASON],
          value: kcContext.userProfile.commercial_use_reason,
        },
        {
          name: [FORM_FIELDS.AFFILIATION],
          value: kcContext.userProfile.affiliation,
        },
        {
          name: [FORM_FIELDS.NO_AFFILIATION],
          value: kcContext.userProfile.affiliation ? false : undefined,
        },
        {
          name: [FORM_FIELDS.RESEARCH_AREA],
          value: kcContext.userProfile.research_area,
        },
        {
          name: [FORM_FIELDS.ROLES],
          value: hasOtherRole(kcContext.userProfile.roles ?? [])
            ? [...(kcContext.userProfile.roles ?? []), OTHER_KEY]
            : kcContext.userProfile.roles,
        },
        {
          name: [FORM_FIELDS.OTHER_ROLE],
          value: hasOtherRole(kcContext.userProfile.roles ?? []),
        },
        {
          name: [FORM_FIELDS.DATA_USAGE],
          value: hasOtherUsage(kcContext.userProfile.portal_usages ?? [])
            ? [...(kcContext.userProfile.portal_usages ?? []), OTHER_KEY]
            : kcContext.userProfile.portal_usages,
        },
        {
          name: [FORM_FIELDS.OTHER_DATA_USAGE],
          value: hasOtherUsage(kcContext.userProfile.portal_usages ?? []),
        },
        {
          name: [FORM_FIELDS.COMMERCIAL_USE_REASON],
          value: kcContext.userProfile.commercial_use_reason,
        },
      ]}
      onFinish={(values) => {
        dispatch(
          userLogin({
            url: kcContext.url.loginAction,
            redirectUrl: kcContext.redirectUrl,
            userInfo: {
              first_name: values[FORM_FIELDS.FIRST_NAME],
              last_name: values[FORM_FIELDS.LAST_NAME],
              era_commons_id:
                values[FORM_FIELDS.EXTERNAL_ID] === EXTERNAL_ID_OPTIONS.ERA
                  ? values[FORM_FIELDS.USER_ID]
                  : undefined,
              external_individual_fullname: values[FORM_FIELDS.FULL_NAME],
              external_individual_email: values[FORM_FIELDS.EXTERNAL_EMAIL],
              roles: removeOtherKey(
                values[FORM_FIELDS.ROLES],
                values[FORM_FIELDS.OTHER_ROLE]
              ),
              affiliation: values[FORM_FIELDS.AFFILIATION],
              research_area: values[FORM_FIELDS.RESEARCH_AREA],
              portal_usages: removeOtherKey(
                values[FORM_FIELDS.DATA_USAGE],
                values[FORM_FIELDS.OTHER_DATA_USAGE]
              ),
              commercial_use_reason: values[FORM_FIELDS.COMMERCIAL_USE_REASON],
            },
          })
        );
      }}
      layout="vertical"
      validateMessages={validateMessages}
    >
      <Title level={3} className={styles.subSectionTitle}>
        Identification
      </Title>
      <Text className={styles.allFieldRequiredNotice}>
        Information provided here will be shared with the INCLUDE community on
        the INCLUDE Portal. All fields are required unless specified as
        optional.
      </Text>
      <Form.Item
        name={FORM_FIELDS.FIRST_NAME}
        label="First Name"
        required={false}
        rules={[
          { required: true, type: "string", validateTrigger: "onSubmit" },
        ]}
      >
        <Input />
      </Form.Item>
      <Form.Item
        name={FORM_FIELDS.LAST_NAME}
        label="Last Name"
        required={false}
        rules={[
          { required: true, type: "string", validateTrigger: "onSubmit" },
        ]}
      >
        <Input />
      </Form.Item>
      <Form.Item
        name={FORM_FIELDS.EXTERNAL_ID}
        label="I have an eRA Commons ID:"
        rules={[{ required: true }]}
        required={false}
        className={styles.haveAUserID}
      >
        <Radio.Group>
          <Space direction="vertical">
            <Radio value={EXTERNAL_ID_OPTIONS.ERA}>Yes</Radio>
            <Radio value={EXTERNAL_ID_OPTIONS.NO}>No</Radio>
          </Space>
        </Radio.Group>
      </Form.Item>
      <Form.Item
        noStyle
        shouldUpdate={(prevValues, currentValues) =>
          prevValues[FORM_FIELDS.EXTERNAL_ID] !==
          currentValues[FORM_FIELDS.EXTERNAL_ID]
        }
      >
        {({ getFieldValue }) =>
          getFieldValue(FORM_FIELDS.EXTERNAL_ID) === EXTERNAL_ID_OPTIONS.ERA ? (
            <Form.Item
              className={cx(styles.withCustomHelp, styles.dynamicField)}
              label="Please enter your eRA Commons ID"
            >
              <span className={styles.help}>
                This information will not be made public.
              </span>
              <Form.Item
                name={FORM_FIELDS.USER_ID}
                rules={[{ required: true }]}
              >
                <Input />
              </Form.Item>
            </Form.Item>
          ) : null
        }
      </Form.Item>
      <Form.Item
        noStyle
        shouldUpdate={(prevValues, currentValues) =>
          prevValues[FORM_FIELDS.EXTERNAL_ID] !==
          currentValues[FORM_FIELDS.EXTERNAL_ID]
        }
      >
        {({ getFieldValue }) =>
          getFieldValue(FORM_FIELDS.EXTERNAL_ID) === EXTERNAL_ID_OPTIONS.NO ? (
            <div className={styles.dynamicField}>
              <span className={styles.help}>
                Please provide the name and email address of an individual at
                your institution, organization, or similar who is aware of your
                intended use of the data (We do not expect to contact this
                individual except in cases where we need to verify your
                identity).
              </span>
              <Form.Item
                name={FORM_FIELDS.FULL_NAME}
                label="Full Name"
                rules={[{ required: true }]}
                className={styles.fullNameField}
                required={false}
              >
                <Input placeholder="First Last" />
              </Form.Item>
              <Form.Item
                name={FORM_FIELDS.EXTERNAL_EMAIL}
                label="Email"
                rules={[{ required: true, type: "email" }]}
                required={false}
              >
                <Input
                  placeholder="name@domain.com"
                  suffix={<MailOutlined className={styles.iconSuffix} />}
                />
              </Form.Item>
            </div>
          ) : null
        }
      </Form.Item>
      <Title level={3} className={styles.subSectionTitle}>
        Role & Affiliation
      </Title>
      <Form.Item
        className={styles.withCustomHelp}
        name={FORM_FIELDS.ROLES}
        label="I am a:"
        required={false}
        rules={[{ required: true }]}
      >
        <Checkbox.Group className={styles.checkBoxGroup}>
          <span className={styles.help}>Check all that apply</span>
          <Space direction="vertical">
            {roleOptions.map((option, index) => (
              <Checkbox key={index} value={option.toLowerCase()}>
                {option}
              </Checkbox>
            ))}
            <Checkbox value={OTHER_KEY}>Other</Checkbox>
          </Space>
        </Checkbox.Group>
      </Form.Item>
      <Form.Item
        noStyle
        shouldUpdate={(prevValues, currentValues) =>
          prevValues[FORM_FIELDS.ROLES] !== currentValues[FORM_FIELDS.ROLES]
        }
      >
        {({ getFieldValue }) =>
          getFieldValue(FORM_FIELDS.ROLES)?.includes(OTHER_KEY) ? (
            <Form.Item
              className={styles.dynamicField}
              name={FORM_FIELDS.OTHER_ROLE}
              label="Please describe"
              required={false}
              rules={[{ required: true }]}
            >
              <Input />
            </Form.Item>
          ) : null
        }
      </Form.Item>
      <Form.Item
        noStyle
        shouldUpdate={(prevValues, currentValues) =>
          prevValues[FORM_FIELDS.NO_AFFILIATION] !==
          currentValues[FORM_FIELDS.NO_AFFILIATION]
        }
      >
        {({ getFieldValue }) =>
          !getFieldValue(FORM_FIELDS.NO_AFFILIATION) ? (
            <Form.Item
              className={cx(styles.withCustomHelp, styles.affiliationField)}
              label="I am affiliated with:"
            >
              <span className={styles.help}>
                Provide institutional or organizational affiliation
              </span>
              <Form.Item
                name={FORM_FIELDS.AFFILIATION}
                className={styles.noMargin}
                required={false}
                rules={[{ required: true }]}
              >
                <Input />
              </Form.Item>
            </Form.Item>
          ) : null
        }
      </Form.Item>
      <Form.Item
        noStyle
        shouldUpdate={(prevValues, currentValues) =>
          prevValues[FORM_FIELDS.NO_AFFILIATION] !==
          currentValues[FORM_FIELDS.NO_AFFILIATION]
        }
      >
        {() => (
          <Form.Item
            name={FORM_FIELDS.NO_AFFILIATION}
            label={
              form.getFieldValue(FORM_FIELDS.NO_AFFILIATION)
                ? "I am affiliated with:"
                : ""
            }
            className={cx(
              styles.withCustomHelp,
              form.getFieldValue(FORM_FIELDS.NO_AFFILIATION) &&
                styles.noAffiliationField
            )}
            rules={[{ required: false }]}
            valuePropName="checked"
          >
            <Checkbox>I do not have an institutional affiliation</Checkbox>
          </Form.Item>
        )}
      </Form.Item>
      <Form.Item
        className={cx(styles.withCustomHelp, styles.researchAreaField)}
        label="My research area or area of interest may best be described as:"
        requiredMark="optional"
      >
        <span className={styles.help}>
          Provide a brief description and a link to your professional biography
          or organization website, if available
        </span>
        <Form.Item name={FORM_FIELDS.RESEARCH_AREA}>
          <Input.TextArea />
        </Form.Item>
      </Form.Item>
      <Title level={3} className={styles.subSectionTitle}>
        Research & Data Use
      </Title>
      <Form.Item
        className={styles.withCustomHelp}
        name={FORM_FIELDS.DATA_USAGE}
        label="I intend to use the INCLUDE Portal data for:"
        required={false}
        rules={[{ required: true }]}
      >
        <Checkbox.Group className={styles.checkBoxGroup}>
          <span className={styles.help}>Check all that apply</span>
          <Space direction="vertical">
            {usageOptions.map((option) => (
              <Checkbox key={option.key} value={option.value.toLowerCase()}>
                {option.value}
              </Checkbox>
            ))}
            <Form.Item
              noStyle
              shouldUpdate={(prevValues, currentValues) =>
                prevValues[FORM_FIELDS.DATA_USAGE] !==
                currentValues[FORM_FIELDS.DATA_USAGE]
              }
            >
              {({ getFieldValue }) =>
                getFieldValue(FORM_FIELDS.DATA_USAGE)?.includes(
                  usageOptions.find((option) => option.key === "commercial")
                    ?.value
                ) ? (
                  <Form.Item
                    className={cx(styles.dynamicField, styles.inner)}
                    label="Please provide a minimum of 1-2 sentences to describe your commercial use:"
                    name={FORM_FIELDS.COMMERCIAL_USE_REASON}
                    required={false}
                    rules={[{ required: true, min: 70 }]}
                  >
                    <Input />
                  </Form.Item>
                ) : null
              }
            </Form.Item>
            <Checkbox value={OTHER_KEY}>Other</Checkbox>
          </Space>
        </Checkbox.Group>
      </Form.Item>
      <Form.Item
        noStyle
        shouldUpdate={(prevValues, currentValues) =>
          prevValues[FORM_FIELDS.DATA_USAGE] !==
          currentValues[FORM_FIELDS.DATA_USAGE]
        }
      >
        {({ getFieldValue }) =>
          getFieldValue(FORM_FIELDS.DATA_USAGE)?.includes(OTHER_KEY) ? (
            <Form.Item
              className={cx(styles.withCustomHelp, styles.dynamicField)}
              label="Data use statement"
            >
              <span className={styles.help}>
                For other purpose, you must describe your use below
              </span>
              <Form.Item
                name={FORM_FIELDS.OTHER_DATA_USAGE}
                rules={[{ required: true }]}
              >
                <Input.TextArea />
              </Form.Item>
            </Form.Item>
          ) : null
        }
      </Form.Item>
      <Space className={styles.registrationFooter}>
        <Button
          icon={<ArrowLeftOutlined />}
          onClick={() => dispatch(registrationFlowActions.previousStep())}
        >
          Back
        </Button>
        <Space>
          <Button onClick={() => {}}>Cancel</Button>
          <Button type="primary" htmlType="submit">
            Submit
          </Button>
        </Space>
      </Space>
    </Form>
  );
};

export default SurveyStep;
