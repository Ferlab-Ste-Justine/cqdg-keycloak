/*
 * Copyright (c) 2021 The Ontario Institute for Cancer Research. All rights reserved
 *
 * This program and the accompanying materials are made available under the terms of the GNU Affero General Public License v3.0.
 * You should have received a copy of the GNU Affero General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
 * SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
 * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *
 */

package ca.cqdg.forms;

import org.keycloak.authentication.authenticators.broker.util.SerializedBrokeredIdentityContext;
import org.keycloak.events.Details;
import org.keycloak.models.UserModel;
import org.keycloak.models.utils.FormMessage;
import org.keycloak.services.resources.AttributeFormDataProcessor;
import org.keycloak.services.validation.Validation;
import org.keycloak.userprofile.UserProfileAttributes;
import org.keycloak.userprofile.profile.representations.AttributeUserProfile;

import javax.ws.rs.core.MultivaluedMap;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class FormUtils {
    public static final String FIELD_AFFILIATION = "user.attributes.affiliation";
    public static final String FIELD_TITLE = "user.attributes.title";
    public static final String FIELD_RESEARCH_DOMAIN = "user.attributes.researchDomain";

    public static final String MESSAGE_AFFILIATION_REQUIRED = "requiredAffiliationMessage";
    public static final String MESSAGE_AFFILIATION_INVALID = "invalidAffiliationMessage";

    public static final String MESSAGE_TITLE_REQUIRED = "requiredTitleMessage";
    public static final String MESSAGE_TITLE_INVALID = "invalidTitleMessage";

    public static final String MESSAGE_RESEARCH_DOMAIN_REQUIRED = "requiredResearchDomainMessage";
    public static final String MESSAGE_RESEARCH_DOMAIN_INVALID = "invalidResearchDomainMessage";

    public static List<FormMessage> validate(MultivaluedMap<String, String> formData){
        List<FormMessage> errors = new ArrayList<>();
        String affiliation = formData.getFirst(FIELD_AFFILIATION);
        String title = formData.getFirst(FIELD_TITLE);
        String researchDomain = formData.getFirst(FIELD_RESEARCH_DOMAIN);

        if (Validation.isBlank(affiliation)) {
            errors.add(new FormMessage(FIELD_AFFILIATION, MESSAGE_AFFILIATION_REQUIRED));
        }

        if (Validation.isBlank(title)) {
            errors.add(new FormMessage(FIELD_TITLE, MESSAGE_TITLE_REQUIRED));
        }

        if (Validation.isBlank(researchDomain)) {
            errors.add(new FormMessage(FIELD_RESEARCH_DOMAIN, MESSAGE_RESEARCH_DOMAIN_REQUIRED));
        }

        return errors;
    }

    public static void syncContextAttributes(UserModel userModel, SerializedBrokeredIdentityContext userCtx){
        if(userModel != null && userCtx != null){
            Map<String, List<String>> userModelAttributes = userModel.getAttributes();
            userModelAttributes.entrySet().stream().forEach((entry) -> {
                if(userCtx.getAttributes().containsKey(entry.getKey())){
                    userCtx.getAttributes().get(entry.getKey()).addAll(entry.getValue());
                }else{
                    userCtx.setAttribute(entry.getKey(), entry.getValue());
                }
            });
        }
    }

    public static void updateUserAttributes(UserModel userModel, AttributeUserProfile updatedProfile){
        if(userModel != null && updatedProfile != null){
            UserProfileAttributes updatedAttributes = updatedProfile.getAttributes();
            updatedAttributes.entrySet().stream().forEach((entry) -> {
                if(userModel.getAttributes().containsKey(entry.getKey())){
                    userModel.setAttribute(entry.getKey(), entry.getValue());
                }
            });
        }
    }
}
