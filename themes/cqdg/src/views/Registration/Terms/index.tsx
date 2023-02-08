import { ArrowRightOutlined } from "@ant-design/icons";
import ScrollContent from "@ferlab/ui/core/layout/ScrollContent";
import GridCard from "@ferlab/ui/core/view/v2/GridCard";
import { Button, Checkbox, Form, Space, Typography } from "antd";
import { useDispatch } from "react-redux";
import { useRegistrationFlow } from "store/registrationFlow";
import { registrationFlowActions } from "store/registrationFlow/slice";
import { TUser } from "store/registrationFlow/types";
import { KcContext_LoginUpdateProfile } from "..";

import styles from "./index.module.scss";

enum FORM_FIELDS {
  CHECKBOXES = "checkboxes",
}

enum CHECKBOXES_OPTIONS {
  ACCEPTED_TERMS = "accepted_terms",
  UNDERSTAND_DISCLAIMER = "understand_disclaimer",
}

const { Title, Text } = Typography;

const TermsStep = ({
  kcContext,
}: {
  kcContext: KcContext_LoginUpdateProfile;
}) => {
  const dispatch = useDispatch();
  const [form] = Form.useForm();
  const { userInfo } = useRegistrationFlow();

  const getInitialValues = (localUser: TUser) => {
    let value = [];
    if (localUser?.accepted_terms || kcContext.userProfile.accepted_terms) {
      value.push(CHECKBOXES_OPTIONS.ACCEPTED_TERMS);
    }
    if (
      localUser?.understand_disclaimer ||
      kcContext.userProfile.understand_disclaimer
    ) {
      value.push(CHECKBOXES_OPTIONS.UNDERSTAND_DISCLAIMER);
    }
    return value;
  };
  return (
    <Space
      direction="vertical"
      size={24}
      className={styles.termsAndConditionsWrapper}
    >
      <Title level={3} className={styles.mainTitle}>
        INCLUDE Portal Registration Process
      </Title>
      <Text>
        The INCLUDE Portal is the primary entry point to the INCLUDE Data Hub.
        The INCLUDE Portal enables searching, visualizing, and accessing
        INCLUDE-relevant data. Some datasets may require additional approvals
        (e.g., dbGaP) and terms and conditions of access and use.
      </Text>
      <GridCard
        wrapperClassName={styles.cardWrapper}
        className={styles.card}
        title={
          <div className={styles.termsCardHeader}>
            <span className={styles.title}>
              INCLUDE Portal Terms & Conditions
            </span>
            <span className={styles.lastUpdateDate}>
              Last Update: 07/11/2021
            </span>
          </div>
        }
        content={
          <ScrollContent className={styles.termsListWrapper}>
            <ul className={styles.termsList}>
              <li>
                My purpose for the use of INCLUDE Portal data is free from
                discrimination on the grounds of race, ethnicity, nationality,
                gender, age, physical and/or mental ability, sexual orientation,
                gender identity or expression, religion, or any other grounds
                that would impinge on an individual’s rights.
              </li>
              <li>
                I will acknowledge specific dataset(s) and/or applicable
                accession number(s) as well as the INCLUDE Data Hub in my
                dissemination of research findings, as applicable to the medium
                or type of dissemination.
              </li>
              <li>
                I will only share or distribute INCLUDE Portal data under terms
                consistent with this agreement, and the data or derivatives of
                the data may not be sold, in whole or in part, to any individual
                at any point in time for any purpose.
              </li>
              <li>
                I will respect the privacy of research participants, and I will
                make no attempt to identify or contact individual participants
                or groups from whom data were collected or to generate
                information that could allow participants’ identities to be
                readily ascertained.
              </li>
              <li>
                I agree to provide a brief statement regarding my intended use
                of the data on the INCLUDE Portal with my name and affiliation
                which will be publicly displayed for the purpose of transparency
                and collaboration.
              </li>
              <li>
                I understand that participation in the INCLUDE community is
                voluntary and may be terminated by the INCLUDE Portal
                Administrator. I will report any actual or suspected violation
                of this agreement, even if unintentional, to the INCLUDE Portal
                Administrator. I understand that the INCLUDE Portal
                Administrator may take action to remedy any actual or suspected
                violation and/or report such behavior to the appropriate
                authorities. I also understand that the INCLUDE Portal
                Administrator may immediately suspend or terminate my access to
                the INCLUDE Portal if there is an actual or suspected violation
                of this agreement.
              </li>
            </ul>
          </ScrollContent>
        }
      />
      <GridCard
        wrapperClassName={styles.cardWrapper}
        className={styles.card}
        title="INCLUDE Portal Disclaimers"
        content={
          <ul className={styles.termsList}>
            <li>
              Data available in the INCLUDE Portal is provided on an AS-IS basis
              and may change over time.
            </li>
            <li>
              The INCLUDE DCC does not warrant or assume any legal liability or
              responsibility for information, apparatus, product, or process
              contained in the INCLUDE Portal.
            </li>
            <li>
              Content provided on the INCLUDE Portal is for informational
              purposes only and is not intended to be a substitute for
              independent professional medical judgment, advice, diagnosis, or
              treatment.
            </li>
          </ul>
        }
      />
      <Form
        form={form}
        className={styles.checkboxForm}
        onFinish={() => {
          dispatch(registrationFlowActions.acceptTerms());
          dispatch(registrationFlowActions.nextStep());
        }}
        fields={[
          {
            name: [FORM_FIELDS.CHECKBOXES],
            value: getInitialValues(userInfo!),
          },
        ]}
      >
        <Form.Item
          className={styles.checkboxItem}
          name={FORM_FIELDS.CHECKBOXES}
          rules={[
            {
              validator: async (rule, value: string[]) => {
                return value?.length === 2
                  ? Promise.resolve()
                  : Promise.reject(
                      "Please accept the terms & conditions and portal disclaimers."
                    );
              },
              validateTrigger: "onSubmit",
            },
          ]}
        >
          <Checkbox.Group>
            <Space direction="vertical">
              <Checkbox value={CHECKBOXES_OPTIONS.ACCEPTED_TERMS}>
                I have read and agree to the INCLUDE Portal Terms and Conditions
              </Checkbox>
              <Checkbox value={CHECKBOXES_OPTIONS.UNDERSTAND_DISCLAIMER}>
                I have read and understand the INCLUDE Portal Disclaimers
              </Checkbox>
            </Space>
          </Checkbox.Group>
        </Form.Item>
      </Form>
      <Space className={styles.checkboxFormFooter}>
        <Button onClick={() => {}}>Cancel</Button>
        <Button
          type="primary"
          className="iconRight"
          onClick={() => form.submit()}
        >
          Next <ArrowRightOutlined />
        </Button>
      </Space>
    </Space>
  );
};

export default TermsStep;
