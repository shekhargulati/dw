// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.dw.roo.conference.web;

import com.dw.roo.conference.domain.Speaker;
import com.dw.roo.conference.domain.Talk;
import java.io.UnsupportedEncodingException;
import java.lang.Long;
import java.lang.String;
import java.util.Collection;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.joda.time.format.DateTimeFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.core.convert.converter.Converter;
import org.springframework.core.convert.support.GenericConversionService;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect SpeakerController_Roo_Controller {
    
    @Autowired
    private GenericConversionService SpeakerController.conversionService;
    
    @RequestMapping(method = RequestMethod.POST)
    public String SpeakerController.create(@Valid Speaker speaker, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("speaker", speaker);
            addDateTimeFormatPatterns(model);
            return "speakers/create";
        }
        speaker.persist();
        return "redirect:/speakers/" + encodeUrlPathSegment(speaker.getId().toString(), request);
    }
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String SpeakerController.createForm(Model model) {
        model.addAttribute("speaker", new Speaker());
        addDateTimeFormatPatterns(model);
        return "speakers/create";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String SpeakerController.show(@PathVariable("id") Long id, Model model) {
        addDateTimeFormatPatterns(model);
        model.addAttribute("speaker", Speaker.findSpeaker(id));
        model.addAttribute("itemId", id);
        return "speakers/show";
    }
    
    @RequestMapping(method = RequestMethod.GET)
    public String SpeakerController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            model.addAttribute("speakers", Speaker.findSpeakerEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) Speaker.countSpeakers() / sizeNo;
            model.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            model.addAttribute("speakers", Speaker.findAllSpeakers());
        }
        addDateTimeFormatPatterns(model);
        return "speakers/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String SpeakerController.update(@Valid Speaker speaker, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("speaker", speaker);
            addDateTimeFormatPatterns(model);
            return "speakers/update";
        }
        speaker.merge();
        return "redirect:/speakers/" + encodeUrlPathSegment(speaker.getId().toString(), request);
    }
    
    @RequestMapping(value = "/{id}", params = "form", method = RequestMethod.GET)
    public String SpeakerController.updateForm(@PathVariable("id") Long id, Model model) {
        model.addAttribute("speaker", Speaker.findSpeaker(id));
        addDateTimeFormatPatterns(model);
        return "speakers/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String SpeakerController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        Speaker.findSpeaker(id).remove();
        model.addAttribute("page", (page == null) ? "1" : page.toString());
        model.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/speakers?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
    @RequestMapping(params = { "find=ByEmailAndPasswordEquals", "form" }, method = RequestMethod.GET)
    public String SpeakerController.findSpeakersByEmailAndPasswordEqualsForm(Model model) {
        return "speakers/findSpeakersByEmailAndPasswordEquals";
    }
    
    @RequestMapping(params = "find=ByEmailAndPasswordEquals", method = RequestMethod.GET)
    public String SpeakerController.findSpeakersByEmailAndPasswordEquals(@RequestParam("email") String email, @RequestParam("password") String password, Model model) {
        model.addAttribute("speakers", Speaker.findSpeakersByEmailAndPasswordEquals(email, password).getResultList());
        return "speakers/list";
    }
    
    @ModelAttribute("talks")
    public Collection<Talk> SpeakerController.populateTalks() {
        return Talk.findAllTalks();
    }
    
    Converter<Speaker, String> SpeakerController.getSpeakerConverter() {
        return new Converter<Speaker, String>() {
            public String convert(Speaker speaker) {
                return new StringBuilder().append(speaker.getFirstname()).append(" ").append(speaker.getLastname()).append(" ").append(speaker.getEmail()).toString();
            }
        };
    }
    
    Converter<Talk, String> SpeakerController.getTalkConverter() {
        return new Converter<Talk, String>() {
            public String convert(Talk talk) {
                return new StringBuilder().append(talk.getTitle()).append(" ").append(talk.getDescription()).toString();
            }
        };
    }
    
    @PostConstruct
    void SpeakerController.registerConverters() {
        conversionService.addConverter(getSpeakerConverter());
        conversionService.addConverter(getTalkConverter());
    }
    
    void SpeakerController.addDateTimeFormatPatterns(Model model) {
        model.addAttribute("speaker_birthdate_date_format", DateTimeFormat.patternForStyle("S-", LocaleContextHolder.getLocale()));
    }
    
    private String SpeakerController.encodeUrlPathSegment(String pathSegment, HttpServletRequest request) {
        String enc = request.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        }
        catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
